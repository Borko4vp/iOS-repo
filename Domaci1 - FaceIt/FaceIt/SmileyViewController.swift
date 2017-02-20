//
//  SmileyViewController.swift
//  FaceIt
//
//  Created by borko on 2/3/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class SmileyViewController: UIViewController {

    @IBOutlet weak var tapCntLabel: UILabel!
    var tapCnt = 0{
        didSet{
            tapCntLabel.text = "\(tapCnt)"
        }
    }
    let smileySize: CGFloat = 50.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapCnt = 0
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
        performSegue(withIdentifier: SegueNames.sSmileyToHello, sender: self)
    
    }
    
    func tapHeppened(_ sender: UITapGestureRecognizer){
        let point = sender.location(ofTouch: 0, in: self.view)
        var newX = point.x
        var newY = point.y
        if((newY + CGFloat(smileySize/2)) > self.view.bounds.height){
            newY = newY - CGFloat(smileySize/2)
        }
        if((newY - CGFloat(smileySize/2)) < 0){
            newY = newY + CGFloat(smileySize/2)
        }
        if ((newX + CGFloat(smileySize/2)) > self.view.bounds.width){
            newX = newX - CGFloat(smileySize/2)
            
        }
        if ((newX - CGFloat(smileySize/2)) < 0){
            newX = newX + CGFloat(smileySize/2)
        }
        let faceView = FaceView(x: newX, y: newY, size_x: smileySize, size_y: smileySize)
        self.view.addSubview(faceView)
        tapCnt += 1
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
