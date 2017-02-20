//
//  FaceView.swift
//  FaceIt
//
//  Created by CS193p Instructor.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView
{
    // MARK: Public API

    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyesOpen: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyeBrowTilt: Double = -0.5 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    init(x:CGFloat, y:CGFloat, size_x: CGFloat, size_y: CGFloat){
        super.init(frame: CGRect(x: x-size_x/2, y: y-size_y/2, width: size_x, height: size_y))
        self.backgroundColor = UIColor.clear
        scale = CGFloat(arc4random_uniform(100))/100.0
            scale = scale < 0.3 ? scale + 0.5 : scale
        mouthCurvature = Double(arc4random_uniform(3))-1
        eyesOpen = arc4random_uniform(1) > 0 ? true : false
        eyeBrowTilt = Double(arc4random_uniform(2)) - 1
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
        
        lineWidth = CGFloat(arc4random_uniform(3))+1    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Private Implementation

    fileprivate var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    fileprivate var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    fileprivate enum Eye {
        case left
        case right
    }

    fileprivate func pathForCircleCenteredAtPoint(_ midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = lineWidth
        return path
    }
    
    fileprivate func getEyeCenter(_ eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .left: eyeCenter.x -= eyeOffset
        case .right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    fileprivate func pathForEye(_ eye: Eye) -> UIBezierPath
    {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if eyesOpen {
            return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    fileprivate func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset

        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    fileprivate func pathForBrow(_ eye: Eye) -> UIBezierPath
    {
        var tilt = eyeBrowTilt
        switch eye {
        case .left: tilt *= -1.0
        case .right: break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    // MARK: iOS Drawing Method

    override func draw(_ rect: CGRect)
    {
        color.set()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        pathForBrow(.left).stroke()
        pathForBrow(.right).stroke()
    }
    
    // MARK: Constants

    fileprivate struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
}
