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
    var score: Int = 0
    
    init() {
        ref = Database.database().reference()
        questionsList.removeAll()
        currentQuestionIndex = 0
        setupLevel1()
    }
    
    // Bool in tuple indicates if this is end of level
    func getQuestion(isNext: Bool) -> (QuestionModel?, Bool) {
        if isNext {
            // Check if next is within range
            let nextIndex = currentQuestionIndex + 1
            if nextIndex >= 0 && nextIndex < questionsList.count {
                currentQuestionIndex = nextIndex
            }
            else {
                print("Next question is not in list")
                return (nil, true)
            }
        }
        return (getQuestionFor(index: currentQuestionIndex), false)
    }
    
    func updateScore(correctAnswer: Bool) {
        if correctAnswer {
            score += 1
        }
    }
    
    func getResultScore() -> String {
        return "x / \(score)"
    }
    
    func getResultDescription() -> String {
        let res = questionsList.count / 3
        if score <= res {
            return "ok"
        }
        else if score <= res * 2 {
            return "good"
        }
        else {
            return "excellent"
        }
    }
    
    private func setupLevel1() {
        ref.child("level1").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                if let questions = data["questions"] as? [Any], let level = data["level"] as? String {
                    for question in questions {
                        if let question = question as? [String: Any] {
                            if let answer = question["answer"] as? String, let image = question["image"] as? String, let options = question["options"] as? [String] {
                                
                                let questionModel = QuestionModel(imageUrl: image, options: options, answer: answer, level: level)
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
