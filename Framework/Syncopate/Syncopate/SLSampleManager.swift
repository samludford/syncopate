//
//  SLSample.swift
//  SimpleSamplerManager
//
//  Created by Work on 27/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
 *  Instances of this class manage a single sample.
 *
 *  When it receives a tick it tells its SLSamplePlayer
 *  to play the sample it manages.
 */
public class SLSampleManager: NSObject, SLTickReceiver {
    
    public var sampleName: String
    var samplePlayer: SLSamplePlayer
    
    public init(samplePlayer: SLSamplePlayer, sampleName: String) {
        self.sampleName = sampleName
        self.samplePlayer = samplePlayer
    }
    
    /*
     *   MARK: SLTickReceiver Protocol Methods
     */
    public func didReceiveTick() {
        samplePlayer.play(sampleName)
    }
   
}
