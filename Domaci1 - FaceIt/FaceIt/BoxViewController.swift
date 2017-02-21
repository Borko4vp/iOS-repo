//
//  BoxViewController.swift
//  FaceIt
//
//  Created by borko on 2/3/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class BoxViewController: UIViewController {

    @IBOutlet weak var tapCntLabel: UILabel!
    @IBOutlet weak var subviewsCntLabel: UILabel!
    
    var subviewsCnt = 0 {
        didSet{
            subviewsCntLabel.text = "\(subviewsCnt)"
        }
    }
    var tapCnt = 0{
        didSet{
            tapCntLabel.text = "\(tapCnt)"
        }
    }
    let squareSize: CGFloat = 50.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapCnt = 0
        self.subviewsCnt = 0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHeppened(_:)))
        self.view.addGestureRecognizer(gesture)
        let swipeGesture: UISwipeGestureRecognizer = {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHeppened(_:)))
            swipe.direction = UISwipeGestureRecognizerDirection.left
            return swipe
        }()
        self.view.addGestureRecognizer(swipeGesture)
    }
    func swipeHeppened(_ sender: UISwipeGestureRecognizer){
        performSegue(withIdentifier: SegueNames.sBoxToHello, sender: self)
        
    }
    
    func squareTapped(_ sender: UIGestureRecognizer){
        subviewsCnt -= 1
        if let v = sender.view {
            v.removeFromSuperview()
        }
    }
    func tapHeppened(_ sender: UITapGestureRecognizer){
        let point = sender.location(ofTouch: 0, in: self.view)
        var newX = point.x
        var newY = point.y
        if((newY + CGFloat(squareSize*sqrt(2)/2)) > self.view.bounds.height){
            newY = newY - CGFloat(squareSize*sqrt(2)/2)
        }
        if((newY - CGFloat(squareSize*sqrt(2)/2)) < 0){
            newY = newY + CGFloat(squareSize*sqrt(2)/2)
        }
        if ((newX + CGFloat(squareSize*sqrt(2)/2)) > self.view.bounds.width){
            newX = newX - CGFloat(squareSize*sqrt(2)/2)
            
        }
        if ((newX - CGFloat(squareSize*sqrt(2)/2)) < 0){
            newX = newX + CGFloat(squareSize*sqrt(2)/2)
        }
        let squareView = SquareView(x: newX, y: newY, side: squareSize)
        squareView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
            #selector(squareTapped(_:))))
        self.view.addSubview(squareView)
        
        tapCnt += 1
        subviewsCnt += 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
