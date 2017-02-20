//
//  SquareView.swift
//  FaceIt
//
//  Created by BorkoTomic on 2/6/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class SquareView: UIView {

    var dimension: CGFloat = 0
    var color: UIColor = UIColor.clear
    var rotation: CGFloat = 0
    
    init(x:CGFloat, y:CGFloat, side: CGFloat){
        super.init(frame: CGRect(x: x-side*sqrt(2.00)/2, y: y-side*sqrt(2.00)/2, width: side*sqrt(2.00), height: side*sqrt(2.00)))
        dimension = side
        self.backgroundColor = UIColor.clear
        rotation = CGFloat(arc4random_uniform(361))
        let c = arc4random_uniform(6)
        switch c {
        case 0:
            color = UIColor.red
        case 1:
            color = UIColor.blue
        case 2:
            color = UIColor.green
        case 3:
            color = UIColor.yellow
        case 4:
            color = UIColor.orange
        case 5:
            color = UIColor.black
        default:
            break
        }
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeppend(_:))))
    }
    
    func tapHeppend(_ sender: UITapGestureRecognizer){
        self.removeFromSuperview()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //a bit complicated code for calculating the rotating square points 
        //could be simplified
        let path = UIBezierPath()
        var x = dimension*sqrt(2.00)/2 + dimension*sqrt(2.00)/2*cos((rotation-135)*CGFloat(M_PI/180))
        var y = dimension*sqrt(2.00)/2 - dimension*sqrt(2.00)/2*sin((rotation-135)*CGFloat(M_PI/180))
        path.move(to: CGPoint(x:x, y:y))
        
        x = dimension*sqrt(2.00)/2 + dimension*sqrt(2.00)/2*cos((rotation-135+90)*CGFloat(M_PI/180))
        y = dimension*sqrt(2.00)/2 - dimension*sqrt(2.00)/2*sin((rotation-135+90)*CGFloat(M_PI/180))
        path.addLine(to: CGPoint(x: x, y: y))
        
        x = dimension*sqrt(2.00)/2 + dimension*sqrt(2.00)/2*cos((rotation-135+180)*CGFloat(M_PI/180))
        y = dimension*sqrt(2.00)/2 - dimension*sqrt(2.00)/2*sin((rotation-135+180)*CGFloat(M_PI/180))
        path.addLine(to: CGPoint(x: x, y: y))
        
        x = dimension*sqrt(2.00)/2 + dimension*sqrt(2.00)/2*cos((rotation-135+270)*CGFloat(M_PI/180))
        y = dimension*sqrt(2.00)/2 - dimension*sqrt(2.00)/2*sin((rotation-135+270)*CGFloat(M_PI/180))
        path.addLine(to: CGPoint(x: x, y: y))
        
        x = dimension*sqrt(2.00)/2 + dimension*sqrt(2.00)/2*cos((rotation-135+360)*CGFloat(M_PI/180))
        y = dimension*sqrt(2.00)/2 - dimension*sqrt(2.00)/2*sin((rotation-135+360)*CGFloat(M_PI/180))
        path.addLine(to: CGPoint(x: x, y: y))
        
        UIColor.black.setStroke()
        color.setFill()
        path.stroke()
        path.fill()
    
    }
    

}
