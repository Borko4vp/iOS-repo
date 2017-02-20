//
//  MoreInfoViewController.swift
//  FaceIt
//
//  Created by borko on 2/3/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var moreInfoLabel: UILabel!
    var name: String?
    var surname: String?
    var email: String?
    
    @IBOutlet weak var leftArrowView: UIImageView!
    lazy var gesture : UISwipeGestureRecognizer = {
        var ret = UISwipeGestureRecognizer(target: self, action:#selector(MoreInfoViewController.goToMain))
        ret.direction = UISwipeGestureRecognizerDirection.left
        return ret
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftArrowView.isUserInteractionEnabled = true;
        leftArrowView.addGestureRecognizer(gesture)
        
        if let notNilName = name {
            moreInfoLabel.text = notNilName + " Neki text more info bla bla"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func goToMain(){
        performSegue(withIdentifier: SegueNames.sMoreToMain, sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MainViewController{
            dest.emailText = email
            dest.firstNameText = name
            dest.lastNameText = surname
        }
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
