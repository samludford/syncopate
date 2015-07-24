//
//  SLCheckBox.swift
//  SimpleSampler
//
//  Created by Work on 25/04/2015.
//  Copyright (c) 2015 Sam Ludford. All rights reserved.
//

import UIKit

@IBDesignable
class SLCheckBox: UIButton {
    
    @IBInspectable var checked: Bool = false {
        didSet {
            self.refresh()
        }
    }
    
    @IBInspectable var focussed: Bool = false {
        didSet {
            self.refresh()
        }
    }
    
    @IBInspectable var onColor: UIColor = UIColor.blackColor() {
        didSet {
            self.refresh()
        }
    }
    
    @IBInspectable var offColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.refresh()
        }
    }
    
    @IBInspectable var onFocussedColor: UIColor = UIColor.blueColor() {
        didSet {
            self.refresh()
        }
    }
    
    @IBInspectable var offFocussedColor: UIColor = UIColor.grayColor() {
        didSet {
            self.refresh()
        }
    }
    
    func refresh() -> Void {
        var color: UIColor
        if checked {
            if focussed {
                color = onFocussedColor
            } else {
                color = onColor
            }
        } else {
            if focussed {
                color = offFocussedColor
            } else {
                color = offColor
            }
        }
        self.backgroundColor = color
    }
}
