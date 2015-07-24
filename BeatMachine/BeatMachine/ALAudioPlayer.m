//
//  ALAudioPlayer.m
//  SimpleSampler
//
//  Created by Work on 24/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

#import "ALAudioPlayer.h"

#define kMaxConcurrentSources 32
#define kMaxBuffers 256
#define kSampleRate 44100

@implementation ALAudioPlayer

#pragma mark - Singleton

+ (id) sharedInstance
{
    static ALAudioPlayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Init

static ALCdevice *openALDevice;
static ALCcontext *openALContext;

static NSMutableArray *audioSampleSources;
static NSMutableDictionary *audioSampleBuffers;

- (id)init
{
    if (self = [super init])
    {
        openALDevice = alcOpenDevice(NULL);
        openALContext = alcCreateContext(openALDevice, NULL);
        alcMakeContextCurrent(openALContext);
        
        audioSampleSources = [[NSMutableArray alloc] init];
        unsigned int sourceID;
        for(int i=0 ; i < kMaxConcurrentSources ; i++) {
            alGenSources(1, &sourceID);
            [audioSampleSources addObject:[NSNumber numberWithUnsignedInt:sourceID]];
        }
        
        audioSampleBuffers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public Methods

- (void) play:(NSString *) sampleName
{
    ALuint source = [self getNextAvailableSource];
    
    alSourcef(source, AL_PITCH, 1.0f);
    alSourcef(source, AL_GAIN, 1.0f);
    
    ALuint outputBuffer = (ALuint)[[audioSampleBuffers objectForKey:sampleName] intValue];
    
    alSourcei(source, AL_BUFFER, outputBuffer);
    
    alSourcePlay(source);
}

- (void) preload:(NSString *)sampleName
{
    if([audioSampleBuffers objectForKey:sampleName])
    {
        return;
    }
    
    if([audioSampleBuffers count] > kMaxBuffers)
    {
        NSLog(@"warning! you are trying to create more than 256 buffers!");
        return;
    }
    
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:sampleName ofType:@"caf"];
    AudioFileID afid = [self openAudioFile:audioFilePath];
    
    UInt32 audioFileSizeInBytes = [self getSizeOfAudioComponent:afid];
    
    void *audioData = malloc(audioFileSizeInBytes);
    
    OSStatus readBytesResult = AudioFileReadBytes(afid, false, 0, &audioFileSizeInBytes, audioData);
    
    if (0 != readBytesResult)
    {
        NSLog(@"An error occurred when attempting to read data from audio file %@: %d", audioFilePath, (int)readBytesResult);
    }
    
    AudioFileClose(afid);
    
    ALuint outputBuffer;
    alGenBuffers(1, &outputBuffer);
    
    alBufferData(outputBuffer, AL_FORMAT_STEREO16, audioData, audioFileSizeInBytes, kSampleRate);
    
    [audioSampleBuffers setObject:[NSNumber numberWithInt:outputBuffer] forKey:sampleName];
    
    if (audioData)
    {
        free(audioData);
        audioData = NULL;
    }
}

- (void) shutdown
{
    ALint source;
    for (NSNumber *sourceValue in audioSampleSources)
    {
        unsigned int sourceID = [sourceValue unsignedIntValue];
        alGetSourcei(sourceID, AL_SOURCE_STATE, &source);
        alSourceStop(sourceID);
        alDeleteSources(1, &sourceID);
    }
    [audioSampleSources removeAllObjects];
    
    NSArray *bufferIDs = [audioSampleBuffers allValues];
    for (NSNumber *bufferValue in bufferIDs)
    {
        unsigned int bufferID = [bufferValue unsignedIntValue];
        alDeleteBuffers(1, &bufferID);
    }
    [audioSampleBuffers removeAllObjects];
    
    alcDestroyContext(openALContext);
    
    alcCloseDevice(openALDevice);
}

#pragma mark - Utilities


- (AudioFileID) openAudioFile:(NSString *)audioFilePathAsString
{
    
    NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePathAsString];
    
    AudioFileID afid;
    
    OSStatus openAudioFileResult = AudioFileOpenURL((__bridge CFURLRef)audioFileURL, kAudioFileReadPermission, 0, &afid);
    
    if (0 != openAudioFileResult)
    {
        NSLog(@"An error occurred when attempting to open the audio file %@: %d", audioFilePathAsString, (int)openAudioFileResult);
        
    }
    
    return afid;
}

- (UInt32) getSizeOfAudioComponent:(AudioFileID)afid
{
    UInt64 audioDataSize = 0;
    UInt32 propertySize = sizeof(UInt64);
    
    OSStatus getSizeResult = AudioFileGetProperty(afid, kAudioFilePropertyAudioDataByteCount, &propertySize, &audioDataSize);
    
    if (0 != getSizeResult)
    {
        NSLog(@"An error occurred when attempting to determine the size of audio file.");
    }
    
    return (UInt32)audioDataSize;
}

- (ALuint) getNextAvailableSource
{
    ALint sourceState;
    for (NSNumber *sourceID in audioSampleSources) {
        alGetSourcei([sourceID unsignedIntValue], AL_SOURCE_STATE, &sourceState);
        if (sourceState != AL_PLAYING)
        {
            return [sourceID unsignedIntValue];
        }
    }
    
    ALuint sourceID = [[audioSampleSources objectAtIndex:0] unsignedIntValue];
    alSourceStop(sourceID);
    return sourceID;
}




@end
