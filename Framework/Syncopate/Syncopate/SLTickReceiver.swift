//
//  SLTickReceiver.swift
//  SimpleSampler
//
//  Created by Work on 22/07/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import Foundation

/*
*   Conforming classes can register to receive ticks
*   from any SLTicker. (Typically to control audio playback, etc.)
*/
public protocol SLTickReceiver: class {
    func didReceiveTick()
}