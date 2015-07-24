//
//  SLSamplePlayer.swift
//  SimpleSampler
//
//  Created by Work on 22/07/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import Foundation

/*
 *  An interface representing an output point for the Syncopate library. Clients should conform to this
 *  protocol to handle audio playback.
 */
public protocol SLSamplePlayer {
    func play(sampleName: String)
}