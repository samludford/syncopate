//
//  SLMetronome.swift
//  SimpleSampler
//
//  Created by Work on 25/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
 *  A basic metronome which emits ticks at regular intervals,
 *  set according to a bpm (beats per minute) value and a grain
 *  value which determines how many ticks per beat.
 */
public class SLMetronome: SLTicker, SLStateChanger {
    
    
    /*
     *  MARK: SLStateChanger
     */
    public var stateChangeListeners: [SLStateChangeListener] = []
    
    
    /*
     *  State
     */
    private var playing: Bool
    private var tempo: NSTimeInterval
    private var division: Int
    
    
    
    
    /*
     *  Initialisation
     */
    public init(bpm: Double, grain: Int) {
        playing = false
        division = grain
        tempo = SLMath.bpmToTimeInterval(bpm, division: grain)
    }
    
    
    
    
    /*
     *  MARK: Public Methods
     */
    
    public func start() {
        if !playing {
            let metronomeQueue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(metronomeQueue) { () -> Void in
                self.playing = true
                self.play()
            }
        }
    }
    
    public func stop() {
        playing = false
    }
    
    public func setBPM(bpm: Double) {
        tempo = SLMath.bpmToTimeInterval(bpm, division: division)
        for listener in stateChangeListeners {
            listener.stateDidChange(self)
        }
    }
    
    public func getBpm() -> Double {
        return SLMath.timeIntervalToBpm(tempo, division: division)
    }
    
    
    
    
    /*
     *  MARK: Utilities
     */
    
    private func play() {
        
        while playing {

            dispatch_sync(dispatch_get_main_queue()) { () -> Void in
                self.tick()
            }
            
            let curtainTime: NSDate = NSDate(timeIntervalSinceNow: tempo)
            var now: NSDate = NSDate()
            while playing && (now.compare(curtainTime) != NSComparisonResult.OrderedDescending) {
                NSThread.sleepForTimeInterval(0.001)
                now = NSDate()
            }
        }
        
    }
    
   
}
