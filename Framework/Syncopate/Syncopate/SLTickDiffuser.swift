//
//  SLTickDiffuser.swift
//  SimpleSampler
//
//  Created by Work on 25/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
 *  Instances of SLTickDiffuser only tick
 *  for every few they receive, where this number
 *  is determined by the 'diffusion' value.
 */
public class SLTickDiffuser: SLTicker, SLTickReceiver {
    
    /*
    *   Diffusion value represents how many received ticks will
    *   be ignored before a new one is sent.
    */
    public var diffusion: Int
    
    private var count: Int = 0
    
    public init(diffusion: Int) {
        self.diffusion = diffusion
        self.count = diffusion
    }
    
    /*
     *   MARK: SLTickReceiver Protocol Methods
     */
    public func didReceiveTick() {
        if count >= diffusion {
            count = 0
            tick()
        } else {
            count++
        }
    }
   
}
