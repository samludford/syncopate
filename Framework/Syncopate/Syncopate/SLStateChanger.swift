//
//  SLStateChanger.swift
//  SimpleSampler
//
//  Created by Work on 22/07/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import Foundation

/*
 *  Conformers to this protocol maintain a list of listeners who can be notified
 *  of changes to internal state (typically for UI updates, etc.)
 */
public protocol SLStateChanger {
     var stateChangeListeners: [SLStateChangeListener] { get }
}