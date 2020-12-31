//
//  RiddleRepository.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import Foundation

var repository: RiddleRepository!

class RiddleRepository {
    
    var questionsList = [QuestionModel]()
    var currentQuestionIndex: Int = 0
    
    init() {
        let q1 = QuestionModel(imageUrl: "https://i.pinimg.com/originals/e1/dc/57/e1dc574a122ee009c1bb8571a4981c8b.png", options: ["मल्लक", "केशाः", "लोचन", "नखर"], answer: "लोचन")
        let q2 = QuestionModel(imageUrl: "https://library.kissclipart.com/20190224/wwq/kissclipart-dog-clipart-puppy-maltese-dog-beagle-3400a99cc8df2422.png", options: ["श्वान", "बिडाला", "मूषक", "पीवन्"], answer: "श्वान")
        
        questionsList = [q1, q2]
        currentQuestionIndex = 0
    }
    
    func getQuestion(isNext: Bool) -> QuestionModel? {
        if isNext {
            // Check if next is within range
            let nextIndex = currentQuestionIndex + 1
            if nextIndex >= 0 && nextIndex < questionsList.count {
                currentQuestionIndex = nextIndex
            }
            else {
                print("Next question is not in list")
                return nil
            }
        }
        return getQuestionFor(index: currentQuestionIndex)
    }
    
    private func getQuestionFor(index: Int) -> QuestionModel? {
        if index >= 0 && index < questionsList.count {
            return questionsList[index]
        }
        return nil
    }
    
}
