//
//  SLTicker.swift
//  SimpleSampler
//
//  Created by Work on 25/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
*   Class: SLTicker
*
*   Abstract level class representing a generic
*   tick emitter.
*/
public class SLTicker: NSObject {
    
    /*
    *   Ticker ID
    */
    public var id: Int = 0
    
    /*
    *   An array of tick receivers
    */
    private var receivers: [SLTickReceiver] = []

    
    /*
    *   Register a tick receiver
    */
    public func addReceiver(receiver: SLTickReceiver) {
        receivers.append(receiver)
    }
    
    /*
    *   Deregister a tick receiver
    */
    public func removeReceiver(receiver: SLTickReceiver) {
        for i in 0..<receivers.count {
            if receivers[i] === receiver {
                receivers.removeAtIndex(i)
            }
        }
    }
    
    /*
    *   Send tick to all receivers
    */
    public func tick() {
        for receiver in receivers {
            receiver.didReceiveTick(self)
        }
    }
    
}
