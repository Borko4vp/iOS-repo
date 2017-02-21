//
//  GuessGame.swift
//  GuessGame
//
//  Created by borko on 2/14/17.
//  Copyright © 2017 borkotomic@endava. All rights reserved.
//

import Foundation

class GuessGame{

    private var currentNumberOfErrors: Int
    private let maximumNumberOfErrorsAllowed: Int = 3
    
    private var currentQuestion: Int = 0
    private var currentIndexInQuestion: Int = 0
    
    private var questions : [Animal]
    
    init()
    {
        currentQuestion = 0
        currentIndexInQuestion = 0
        currentNumberOfErrors = 0
        questions = [Animal(imageName:"rabbitImage", correct:"rabbit", proposed:"turtlerabbit"),
                     Animal(imageName:"turtleImage", correct:"turtle", proposed:"turtleabcdef"),
                     Animal(imageName:"zebraImage", correct:"zebra", proposed:"azrefbdriagn"),
                     Animal(imageName:"dogImage", correct:"dog", proposed:"hdgjuiofrnmb"),
                     Animal(imageName:"mouseImage", correct:"mouse", proposed:"epoklmhgusrv"),
                     Animal(imageName:"horseImage", correct:"horse", proposed:"jklhferovbsa")]
    }

    private class Animal{
        var image: String
        var correctAnswer: String
        var proposedLetters:String
        
        init(imageName:String, correct:String, proposed:String){
            image = imageName
            correctAnswer = correct
            proposedLetters = proposed
        }
        
    }
    func getCurrentQuestionImageName() -> String{
        return questions[currentQuestion].image
    }
    func getCurrentQuestionCorrectAnswerSize() -> Int{
        return questions[currentQuestion].correctAnswer.characters.count
    }
    func getCurrentQuestionProposedLetters() -> String{
        return questions[currentQuestion].proposedLetters
    }
    func nextQuestion(){
        currentQuestion += 1
        currentIndexInQuestion = 0
        if currentQuestion == questions.count{
            currentQuestion = 0
        }
    }
    
    func check(letter:String) -> (retValue:Int, Index:Int){
        let correctLetter: Character = questions[currentQuestion].correctAnswer[currentIndexInQuestion]
        if (correctLetter == letter[0]){
            if (currentIndexInQuestion == questions[currentQuestion].correctAnswer.characters.count-1){
                let retCurrent = currentIndexInQuestion
                currentIndexInQuestion = 0
                if currentQuestion == questions.count-1{
                    return (4,retCurrent)
                }
                return (2, retCurrent);
            }
            else{
                let retCurrent = currentIndexInQuestion
                currentIndexInQuestion += 1
                return (1, retCurrent)
            }
        }
        
        currentNumberOfErrors += 1
        if maximumNumberOfErrorsAllowed == currentNumberOfErrors{
            currentNumberOfErrors = 0
            return (3, 0)
        }
        return (0, currentIndexInQuestion)
    }
    
    
    func restartGame(){
        currentQuestion = 0
        currentIndexInQuestion = 0
        currentNumberOfErrors = 0
    
    }
    func restartLevel(){
        currentIndexInQuestion = 0
        //currentNumberOfErrors = 0
    }
}
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(start, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}
