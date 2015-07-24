//
//  ALAudioPlayer.h
//  SimpleSampler
//
//  Created by Work on 24/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAl/al.h>
#import <OpenAL/alc.h>
#include <AudioToolbox/AudioToolbox.h>

@interface ALAudioPlayer : NSObject

+ (ALAudioPlayer *) sharedInstance;

- (void) play:(NSString *)sampleName;
- (void) preload:(NSString *)sampleName;
- (void) shutdown;

@end
