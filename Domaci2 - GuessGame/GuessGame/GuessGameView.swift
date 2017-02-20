//
//  GuessGameView.swift
//  GuessGame
//
//  Created by borko on 2/14/17.
//  Copyright © 2017 borkotomic@endava. All rights reserved.
//

import UIKit

class GuessGameView : UIView
{

}

extension UIView {
    
    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds(fromPercentWidth:CGFloat,toPercentWidth:CGFloat, fromPercentHeight: CGFloat, toPercentHeight:CGFloat) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = ((self.superview?.bounds.height)! * fromPercentHeight)/100
        let bottom = ((self.superview?.bounds.height)! * toPercentHeight)/100
        let left = ((self.superview?.bounds.width)! * fromPercentWidth)/100
        let right = ((self.superview?.bounds.width)! * toPercentWidth)/100
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[subview]-right-|", options: .directionLeadingToTrailing, metrics:["left":left, "right":right], views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subview]-bottom-|", options: .directionLeadingToTrailing, metrics:["top":top, "bottom":bottom], views: ["subview": self]))
    }
    
}
