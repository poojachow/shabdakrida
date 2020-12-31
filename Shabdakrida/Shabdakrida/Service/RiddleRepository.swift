//
//  RiddleRepository.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import Foundation
import Firebase

var repository: RiddleRepository!

class RiddleRepository {
    
    var questionsList = [QuestionModel]()
    var currentQuestionIndex: Int = 0
    var ref: DatabaseReference
    
    init() {
        ref = Database.database().reference()
        let q1 = QuestionModel(imageUrl: "https://i.pinimg.com/originals/e1/dc/57/e1dc574a122ee009c1bb8571a4981c8b.png", options: ["मल्लक", "केशाः", "लोचन", "नखर"], answer: "लोचन")
        let q2 = QuestionModel(imageUrl: "https://www.dogsinpictures.com/images/brown_white_clipart_dog_with_red_collar.jpg", options: ["श्वान", "बिडाला", "मूषक", "पीवन्"], answer: "श्वान")
        
        questionsList = [q1, q2]
        currentQuestionIndex = 0
    }
    
    func getQuestion(isNext: Bool) -> QuestionModel? {
        ref.child("level1").observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                print("######")
                print(data["level"])
                print(data["questions"])
                if let questions = data["questions"] as? [Any] {
                    for question in questions {
                        print("######")
                        if let question = question as? [String: Any] {
                            print(question["answer"])
                            print(question["image"])
                            print(question["options"])
                        }
                    }
                }
            }
        } withCancel: { (error) in
            print("ERROR: No permission - \(error)")
        }
        
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
