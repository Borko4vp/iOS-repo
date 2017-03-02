//
//  GuessGame.swift
//  GuessGame
//
//  Created by borko on 2/14/17.
//  Copyright © 2017 borkotomic@endava. All rights reserved.
//

import Foundation

//typealias CheckReturnType = (retValue: Int, index: Int)

public enum ReturnValue{
    case correctLetterInserted
    case inCorrectLetterInserted
    case levelCleared
    case gameWon
    case gameOver
    
}
public struct ReturnType{
    var retValue:ReturnValue
    var index: Int
    init (ret:ReturnValue, i:Int){
        retValue = ret
        index = i
    }
}


class GuessGame{

    private var currentNumberOfErrors: Int
    private let maximumNumberOfErrorsAllowed: Int = 3
    
    private var currentQuestion: Int = 0
    private var currentIndexInQuestion: Int = 0
    
    private let numberOfProposedLetters: Int  = 12
    
    private var questions : [Animal]
    
    init()
    {
        currentQuestion = 0
        currentIndexInQuestion = 0
        currentNumberOfErrors = 0
        questions = [Animal(imageName:"rabbitImage", correct:"rabbit",proposedLettersCnt: numberOfProposedLetters),
                     Animal(imageName:"turtleImage", correct:"turtle",proposedLettersCnt: numberOfProposedLetters),
                     Animal(imageName:"zebraImage", correct:"zebra",proposedLettersCnt: numberOfProposedLetters),
                     Animal(imageName:"dogImage", correct:"dog",proposedLettersCnt: numberOfProposedLetters),
                     Animal(imageName:"mouseImage", correct:"mouse",proposedLettersCnt: numberOfProposedLetters),
                     Animal(imageName:"horseImage", correct:"horse",proposedLettersCnt: numberOfProposedLetters)]
    }

    private class Animal{
        var image: String
        var correctAnswer: String
        var proposedLetters:String
        
        init(imageName:String, correct:String, proposedLettersCnt:Int){
            image = imageName
            correctAnswer = correct
            proposedLetters = String()
            proposedLetters = generateProposedLettersFor(howMany:proposedLettersCnt)
        }
        func generateProposedLettersFor(howMany:Int)-> String{
            let lettersPool = "abcdefghijklmnopqrstuvwxyz"
            var retString = self.correctAnswer
            for _ in 0..<howMany-self.correctAnswer.characters.count {
                let rand = Int(arc4random_uniform(UInt32(lettersPool.characters.count)))
                retString.append(lettersPool[rand] as Character)
            }
            return retString.shuffleCharacters()
        }
        
    }
    private func shuffleAllTheProposeds(){
        for index in 0..<questions.count{
            questions[index].proposedLetters = questions[index].proposedLetters.shuffleCharacters()
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
    
    func check(letter:String) -> ReturnType{
        let correctLetter: Character = questions[currentQuestion].correctAnswer[currentIndexInQuestion]
        if (correctLetter == letter[0]){ //if the letter user clicked is correct
            if (currentIndexInQuestion == questions[currentQuestion].correctAnswer.characters.count-1){//if the letter user clicked is correct and it is the last one in the word
                let retCurrent = currentIndexInQuestion
                currentIndexInQuestion = 0
                if currentQuestion == questions.count-1{ //if word is last one in the questions array
                    return ReturnType(ret: ReturnValue.gameWon,i: retCurrent)
                }
                return ReturnType(ret: ReturnValue.levelCleared, i: retCurrent);
            }
            else{
                let retCurrent = currentIndexInQuestion
                currentIndexInQuestion += 1
                return ReturnType(ret: ReturnValue.correctLetterInserted, i: retCurrent)
            }
        }
        
        currentNumberOfErrors += 1
        if maximumNumberOfErrorsAllowed == currentNumberOfErrors{
            currentNumberOfErrors = 0
            return ReturnType(ret: ReturnValue.gameOver, i: 0)
        }
        return ReturnType(ret: ReturnValue.inCorrectLetterInserted, i: currentIndexInQuestion)
    }
    
    
    func restartGame(){
        currentQuestion = 0
        currentIndexInQuestion = 0
        currentNumberOfErrors = 0
        shuffleAllTheProposeds()
    
    }
    func restartLevel(){
        currentIndexInQuestion = 0
        questions[currentQuestion].proposedLetters = questions[currentQuestion].proposedLetters.shuffleCharacters()
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
    func shuffleCharacters() -> String{
        var lettersPool = self
        var retString  = ""
        while lettersPool.characters.count > 0 {
            let rand = Int(arc4random_uniform(UInt32(lettersPool.characters.count)))
            retString.append(lettersPool.remove(at: lettersPool.index(lettersPool.startIndex, offsetBy: rand)))
        }
        return retString
    }
}
