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
        questionsList.removeAll()
        currentQuestionIndex = 0
        setupLevel1()
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
    
    private func setupLevel1() {
        ref.child("level1").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                if let questions = data["questions"] as? [Any] {
                    for question in questions {
                        if let question = question as? [String: Any] {
                            if let answer = question["answer"] as? String, let image = question["image"] as? String, let options = question["options"] as? [String] {
                                
                                let questionModel = QuestionModel(imageUrl: image, options: options, answer: answer)
                                self?.questionsList.append(questionModel)
                            }
                        }
                    }
                }
            }
        } withCancel: { (error) in
            print("ERROR: No permission - \(error)")
        }
    }
    
    private func getQuestionFor(index: Int) -> QuestionModel? {
        if index >= 0 && index < questionsList.count {
            return questionsList[index]
        }
        return nil
    }
    
}
