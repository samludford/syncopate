//
//  SLStateChangeListener.swift
//  SimpleSampler
//
//  Created by Work on 22/07/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import Foundation

/*
 *  Conformers to this protocol can register for internal state change
 *  notifications from conformers to the SLStateChangeable protocol.
 *  (Typically for UI updates, etc.)
 */
public protocol SLStateChangeListener {
    func stateDidChange(sender: SLStateChanger)
}