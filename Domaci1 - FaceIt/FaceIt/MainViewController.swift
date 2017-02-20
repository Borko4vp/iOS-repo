//
//  ViewController.swift
//  FaceIt
//
//  Created by borko on 2/3/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    ////outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var rightArrowView: UIImageView!
    
    var firstNameText: String?
    var lastNameText: String?
    var emailText: String?
    
    lazy var gesture : UISwipeGestureRecognizer = {
        var ret = UISwipeGestureRecognizer(target: self, action:#selector(MainViewController.goToMoreInfo))
        ret.direction = UISwipeGestureRecognizerDirection.right
        return ret
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*self.firstNameTextField.placeholder = "First name"
        self.lastNameTextField.placeholder = "Last name"
        self.emailTextField.placeholder = "Email"*/
    
        rightArrowView.isUserInteractionEnabled = true;
        rightArrowView.addGestureRecognizer(gesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let firstNameText_ = firstNameText {
            firstNameTextField.text = firstNameText_
        }
        if let lastNameText_ = lastNameText {
            lastNameTextField.text = lastNameText_
        }
        if let emailText_ = emailText {
            emailTextField.text = emailText_
        }
        
    }
    
    @IBAction func onLoginBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueNames.sMainToHello, sender: self)
    }
    
    public func goToMoreInfo(){
        performSegue(withIdentifier: SegueNames.sMainToMore, sender: self)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if let dest = segue.destination as? MoreInfoViewController{
            dest.name = self.firstNameTextField.text
        }*/
        if let id = segue.identifier{
            switch id {
            case SegueNames.sMainToHello:
                if let vc = segue.destination as? HelloViewController{
                    vc.name = self.firstNameTextField.text
                    vc.surname = self.lastNameTextField.text
                }
            case SegueNames.sMainToMore:
                if let vc = segue.destination as? MoreInfoViewController{
                    vc.name = self.firstNameTextField.text
                    vc.surname = self.lastNameTextField.text
                    vc.email = self.emailTextField.text
                }
            default:
                break
            }
            
        }
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
