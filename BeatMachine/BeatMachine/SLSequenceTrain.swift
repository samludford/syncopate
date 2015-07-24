//
//  SLSequenceTrain.swift
//  SimpleSampler
//
//  Created by Work on 27/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

protocol SLSequenceTrainDelegate {
    func patternDidChange(sequenceTrain: SLSequenceTrain, pattern: Pattern)
}

@IBDesignable
class SLSequenceTrain: UIView {
    
    @IBOutlet var checkBoxes: [SLCheckBox] = []

    var view: UIView!
    var delegate: SLSequenceTrainDelegate?
    
    func setFocusedAt(position: Int) {
        for i in 0..<checkBoxes.count {
            checkBoxes[i].focussed = (position == i)
        }
    }
    
    func getPattern() -> Pattern {
        return Pattern( hits: checkBoxes.map { return $0.checked } )
    }
    
    
    @IBAction func checkBoxPressed(sender: SLCheckBox) {
        
        sender.checked = !sender.checked
        
        delegate?.patternDidChange(self, pattern: self.getPattern())
        
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }

    
    func xibSetup() {
        
        view  = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SLSequenceTrain", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    

}
