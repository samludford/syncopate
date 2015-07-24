//
//  SLRhythm.swift
//  SimpleSampler
//
//  Created by Work on 25/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
 *  Instances manage an SLPattern instance: maintaining the (current) position in the pattern,
 *  ticking when the position falls on an 'on' hit, and posting state change notifications
 *  every time the position changes (i.e. whenever it receives a tick).
 */
public class SLPatternManager: SLTicker, SLTickReceiver, SLStateChanger {
    
    
    
    /*
     *  MARK: SLStateChangeable
     */
    public var stateChangeListeners: [SLStateChangeListener] = []
    
    
    
    
    /*
     *  State
     */
    
    public var pattern: Pattern
    
    public var length: Int {
        get {
            return pattern.hits.count
        }
    }

    public var position: Int
    
    
    
    /*
     *  Initialisation
     */
    
    public init(pattern: Pattern) {
        
        position = -1
        
        self.pattern = pattern
        
    }
    
    
    
    /*
     *  SLTickReceiver Protocol Methods
     */
    
    public func didReceiveTick() {
        
        position++
        
        if position >= length {
            position = 0
        }
        
        for listener in stateChangeListeners {
            listener.stateDidChange(self)
        }
        
        
        if pattern.hits[position] {
            tick()
        }
    }
    
   
}
