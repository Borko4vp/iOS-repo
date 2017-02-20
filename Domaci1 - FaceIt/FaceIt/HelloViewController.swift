//
//  HelloViewController.swift
//  FaceIt
//
//  Created by borko on 2/3/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    
    var name: String?
    var surname: String?
    var cnt: Int = 0
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloLabel.text = "Hello, " + (name ?? " ") + (surname ?? " ")
        
        backBtn.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(btnLongPressed)))
        // Do any additional setup after loading the view.
    }

    func btnLongPressed(){
        if cnt == 0{
            performSegue(withIdentifier: SegueNames.sHelloToMain, sender: self)
        }
        cnt += 1
        // For some reason this was called twice on long press, so i implemented skipping of the second call :)
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
