//
//  SLStructs.swift
//  SimpleSampler
//
//  Created by Work on 26/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import Foundation


/*
 *  A simple struct representing a sequence of beats in an on/off state
 */
public struct Pattern {
    
    public var hits: [Bool]
    
    public init(hits: [Bool]) {
        self.hits = hits
    }
    
    func invert() -> Pattern {
        let invertedHits = hits.map { return !$0 }
        return Pattern( hits: invertedHits )
    }
    
}