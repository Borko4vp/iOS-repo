//
//  ViewController.swift
//  GuessGame
//
//  Created by borko on 2/14/17.
//  Copyright © 2017 borkotomic@endava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game:GuessGame?
    var popUpView: UIView?
    @IBOutlet weak var lettersBottomView: UIView!
    @IBOutlet weak var correctAnswerLettersView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func newGameBtnTapped(_ sender: UIButton) {
        game?.restartGame()
        enableAllLetterBtns()
        addCorrectAnswerLettersToView(letterCount: (game?.getCurrentQuestionCorrectAnswerSize())!)
        addProposedLettersToView()
        addImageToView()
        self.popUpView?.removeFromSuperview()
    }
    @IBAction func letterBtnTapped(_ sender: UIButton) {
        if let letterLabel = sender.titleLabel{
            if let letter = letterLabel.text, 1 == letterLabel.text?.characters.count{
                //send the tapped letter to the game
                if let checkRet = game?.check(letter: letter){
                    print("\(checkRet)")
                    switch checkRet.retValue{
                    case 0: break
                    case 1:
                        setCorrectLetterColorAndTitle(title: letterLabel.text!, color: UIColor.yellow, withIndex:checkRet.Index)
                        disableBtn(btn: sender)
                        
                    case 2:
                        setCorrectLetterColorAndTitle(title: letterLabel.text!, color: UIColor.yellow, withIndex:checkRet.Index)
                        game?.nextQuestion()
                        enableAllLetterBtns()
                        addCorrectAnswerLettersToView(letterCount:(game?.getCurrentQuestionCorrectAnswerSize())!)
                        addProposedLettersToView()
                        addImageToView()
                    case 3:
                        createPopUpViewWith(text: "GAME OVER", andColor:UIColor.darkGray)
                        disableAllLetterBtns()//game over
                    case 4:
                        setCorrectLetterColorAndTitle(title: letterLabel.text!, color: UIColor.yellow, withIndex:checkRet.Index)
                        createPopUpViewWith(text: "YEYE!!!", andColor:UIColor.green)
                        disableAllLetterBtns()
                    default:break
                    }
                }
                
            }
        }
    }
    func setCorrectLetterColorAndTitle(title: String, color: UIColor, withIndex:Int){
        if let btn = correctAnswerLettersView.subviews[withIndex] as? UIButton{
            btn.setTitle(title, for: UIControlState.normal)
            btn.backgroundColor = color
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        }
    }

    func createPopUpViewWith(text: String, andColor:UIColor){
    
        let popUp: UIView = UIView(frame: CGRect(x: self.view.frame.size.width*0.05, y: self.imageView.frame.size.height/2 + self.view.frame.size.height*0.1,
                                             width: self.view.frame.size.width*0.9, height: self.view.bounds.height*0.2))
        popUp.backgroundColor = andColor
        let labela: UILabel = UILabel(frame: popUp.bounds)
        labela.text = text
        labela.textColor = UIColor.white
        labela.textAlignment = NSTextAlignment.center
        popUp.addSubview(labela)
        self.popUpView = popUp
        self.view.addSubview(popUp)
        
        
    }
    func disableBtn(btn: UIButton){
        btn.isEnabled = false
        btn.backgroundColor = UIColor.gray
    }
    func enableBtn(btn: UIButton){
        btn.isEnabled = true
        btn.backgroundColor = UIColor.blue
    }
    func disableAllLetterBtns(){
        var index: Int = 0
        while(index < lettersBottomView.subviews.count){
            if let btn = lettersBottomView.subviews[index] as? UIButton{
               disableBtn(btn: btn)
            }
            index+=1
        }

    }
    func enableAllLetterBtns(){
        var index: Int = 0
        while(index < lettersBottomView.subviews.count){
            if let btn = lettersBottomView.subviews[index] as? UIButton{
               enableBtn(btn: btn)
            }
            index+=1
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = GuessGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool){
        addCorrectAnswerLettersToView(letterCount: (game?.getCurrentQuestionCorrectAnswerSize())!)
        addProposedLettersToView()
        addImageToView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addImageToView(){
        imageView.image = UIImage(named: (game?.getCurrentQuestionImageName())!)
    }
    func addProposedLettersToView(){
        var index: Int = 0
        let letters = game?.getCurrentQuestionProposedLetters()
        while(index < lettersBottomView.subviews.count){
            if let btn = lettersBottomView.subviews[index] as? UIButton, let letters_pom = letters {
                btn.setTitle(letters_pom[index], for: UIControlState.normal)
            }
            index+=1
        }
    }
    func addCorrectAnswerLettersToView(letterCount:Int){
        while 0 < correctAnswerLettersView.subviews.count{
            let subview = correctAnswerLettersView.subviews[correctAnswerLettersView.subviews.count-1]
            subview.removeFromSuperview()
        }
        
        let btnWidth = correctAnswerLettersView.bounds.width/6  - 5.8
        let btnHeight = correctAnswerLettersView.bounds.height - 10
        let space = (correctAnswerLettersView.bounds.width - CGFloat(letterCount)*btnWidth)/CGFloat(letterCount+1)
        /*if(0 == letterCount % 2){
            for i in 0..<letterCount/2{
                let btnLeft = UIButton(frame: CGRect(x: correctAnswerLettersView.bounds.midX-space/2*CGFloat(2*i+1)-btnWidth*CGFloat(i+1), y: 5, width: btnWidth, height: btnHeight))
                let btnRight = UIButton(frame: CGRect(x: correctAnswerLettersView.bounds.midX+space/2*CGFloat(2*i+1)+btnWidth*CGFloat(i), y: 5, width: btnWidth, height: btnHeight))
                print(btnLeft.frame)
                print(btnRight.frame)
                btnLeft.backgroundColor = UIColor.black
                btnRight.backgroundColor = UIColor.black
                correctAnswerLettersView.addSubview(btnLeft)
                correctAnswerLettersView.addSubview(btnRight)
            }
        }
        else{
            for i in 0..<letterCount/2{
                if 0 == i {
                    let midBtn = UIButton(frame: CGRect(x: correctAnswerLettersView.bounds.midX-btnWidth/2, y: 5, width: btnWidth, height: btnHeight))
                    midBtn.backgroundColor = UIColor.black
                    correctAnswerLettersView.addSubview(midBtn)
                }
                let btnLeft = UIButton(frame: CGRect(x: correctAnswerLettersView.bounds.midX-btnWidth/2-space*CGFloat(i+1)-btnWidth*CGFloat(i+1), y: 5, width: btnWidth, height: btnHeight))
                let btnRight = UIButton(frame: CGRect(x: correctAnswerLettersView.bounds.midX+btnWidth/2+space*CGFloat(i+1)+btnWidth*CGFloat(i), y: 5, width: btnWidth, height: btnHeight))
                btnLeft.backgroundColor = UIColor.black
                btnRight.backgroundColor = UIColor.black
                correctAnswerLettersView.addSubview(btnLeft)
                correctAnswerLettersView.addSubview(btnRight)
            }
            
        }*/
        for i in 0..<letterCount{
            let btn = UIButton(frame: CGRect(x: space*CGFloat(i+1)+btnWidth*CGFloat(i), y: 5, width: btnWidth, height: btnHeight))
            //print(btn.frame)
            btn.backgroundColor = UIColor.black
            correctAnswerLettersView.addSubview(btn)
        }

    }

}
