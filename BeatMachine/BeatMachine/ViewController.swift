//
//  ViewController.swift
//  SimpleSampler
//
//  Created by Work on 23/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, SLStateChangeListener, SLSamplePlayer, SLSequenceTrainDelegate {

    
    /*
     *  Storyboard Outlets
     */
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet var sequenceTrains: [SLSequenceTrain]!
    
    
    /*
     *  Constants
     */
    
    let sampleFileNames = [ "kick",
                            "snare",
                            "hat_closed",
                            "hat_open",
                            "tom_hi",
                            "tom_low",
                            "clav",
                            "cowbell" ]
    
    
    
    /*
     *  Variables
     */
    
    var audioPlayer: ALAudioPlayer!
    var metronome: SLMetronome?
    var patternManagers: [SLPatternManager]!
    
    
    
    /*
     *  MARK: UIViewController Methods
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 
         * Set Up AVAudioSession
         */
        var sessionError: NSError?
        let session = AVAudioSession.sharedInstance()
        if !session.setCategory(AVAudioSessionCategoryPlayback, error: &sessionError) {
            println("could not set session category")
            if let e = sessionError {
                println(e.localizedDescription)
            }
        }
        
        if !session.setActive(true, error: &sessionError) {
            println("could not activate session")
            if let e = sessionError {
                println(e.localizedDescription)
            }
        }
        
        /*
         *  Initialise audio player and preload samples
         */
        audioPlayer = ALAudioPlayer.sharedInstance()
        for fileName in sampleFileNames {
            audioPlayer.preload(fileName)
        }
        
        /*
         *  Initialise metronome
         */
        metronome = SLMetronome(bpm: 120.0, grain: 4)
        metronome?.stateChangeListeners.append(self)
        metronome?.setBPM(120.0)    // to trigger state change event
        patternManagers = []
        
        /*
         *  Set up tick chain for each sound: metronome -> pattern manager -> sample manager -> output
         */
        for i in 0..<sampleFileNames.count {
            
            // create sample manager
            let sampleManager = SLSampleManager(samplePlayer: self, sampleName: sampleFileNames[i])
            
            // get associated UI element
            let train = sequenceTrains[i]
            
            // create pattern manager object (using train element to avoid hard coding the pattern length)
            let patternManager = SLPatternManager(pattern: train.getPattern())
            
            // register sample manager as a receiver of ticks from this pattern manager
            patternManager.addReceiver(sampleManager)
            
            // set view controller as rhythm delegate (for state change notifications for UI updates)
            patternManager.stateChangeListeners.append(self)
            
            // store reference to pattern manager
            patternManagers?.append(patternManager)
            
            // register pattern manager to receive ticks from the metronome
            metronome?.addReceiver(patternManager)
        }
        
        for train in sequenceTrains {
            train.delegate = self
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
     *  MARK: IBActions
     */

    @IBAction func playButtonPressed(sender: AnyObject) {
        let title = playButton.titleLabel!.text
        if title == "Play" {
            metronome?.start()
            playButton.setTitle("Stop", forState: .Normal)
        } else {
            metronome?.stop()
            playButton.setTitle("Play", forState: .Normal)
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        let value = sender.value
        metronome?.setBPM(value)
    }
    
    
    
    /*
     *  MARK: SLSamplePlayer Protocol Methods
     */
    
    func play(sampleName: String) {
        audioPlayer.play(sampleName)
    }
    
    
    
    /*
     *  MARK: SLStateChangeListener Protocol Methods
     */
    
    func stateDidChange(sender: SLStateChanger) {
        
        if sender is SLMetronome {
            
            let value = metronome?.getBpm()
            bpmLabel.text = String(Int(value!)) + " bpm"
            
        } else {
            
            let patternManager = sender as! SLPatternManager
            for train in sequenceTrains {
                train.setFocusedAt(patternManager.position)
            }
            
        }        

    }
    
    
    /*
    *  MARK: SLSequenceTrainDelegate Protocol Methods
    */
    
    func patternDidChange(sequenceTrain: SLSequenceTrain, pattern: Pattern) {
        // get associated pattern manager & update pattern
        let indexOfTrain = find(sequenceTrains, sequenceTrain)
        let patternManager = patternManagers[indexOfTrain!]
        patternManager.pattern = pattern
    }
    
}

