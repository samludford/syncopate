//
//  SLMath.swift
//  SimpleSampler
//
//  Created by Work on 24/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

/*
 *  A helper class containing mathematical functions
 *  for calculating various music-related calculations.
 */
public class SLMath: NSObject {
    
    // converts beats per minute to time interval (between beats) in milliseconds
    public class func bpmToTimeInterval(bpm: Double, division: Int) -> Double {
        return ( 60.0 / (Double(division) * bpm) )
    }
    
    // converts time interval (between beats) in milliseconds to beats per minute
    public class func timeIntervalToBpm(interval: Double, division: Int) -> Double {
        return ( 60.0 / (interval * Double(division)) )
    }
   
}
