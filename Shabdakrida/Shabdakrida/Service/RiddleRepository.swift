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
    
    var levelsList = [LevelModel]()
    var currentQuestionIndex: Int = 0
    var currentLevelsArrayIndex: Int = 0
    var ref: DatabaseReference
    var score: Int = 0
    
    init() {
        ref = Database.database().reference()
        levelsList.removeAll()
        currentQuestionIndex = 0
        currentLevelsArrayIndex = 0
        setupLevels()
    }
    
    // Bool in tuple indicates if this is end of level
    func getQuestion(isNext: Bool) -> (QuestionModel?, Bool) {
        if isNext {
            // Check if next is within range
            let nextIndex = currentQuestionIndex + 1
            if nextIndex >= 0 && nextIndex < levelsList[currentLevelsArrayIndex].questionsList.count {
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
        let numerator = NumberConverter.getTranslatedNumber(number: score)
        let denominator = NumberConverter.getTranslatedNumber(number: levelsList[currentLevelsArrayIndex].questionsList.count)
        return "\(numerator) / \(denominator)"
    }
    
    func getResultDescription() -> String {
        let result = levelsList[currentLevelsArrayIndex].questionsList.count / 3
        if score <= result {
            return "योग्यम्"
        }
        else if score <= result * 2 {
            return "समिचीनम्"
        }
        else {
            return "उत्तमम्"
        }
    }
    
    private func setupLevels() {
        
        ref.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                for index in 1...data.count {
                    if let levelData = data["level\(index)"] as? [String: Any] {
                        if let type = levelData["type"] as? String, type == "mcq" {
                            var levelName = ""
                            var list = [QuestionModel]()
                            if let questions = levelData["questions"] as? [Any], let level = levelData["level"] as? String {
                                levelName = level
                                for question in questions {
                                    if let question = question as? [String: Any] {
                                        if let answer = question["answer"] as? String, let image = question["image"] as? String, let options = question["options"] as? [String] {

                                            let questionObj = QuestionModel(imageUrl: image, options: options, answer: answer, level: level)
                                            list.append(questionObj)
                                        }
                                    }
                                }
                            }
                            let levelObj = LevelModel(index: index, name: levelName, list: list)
                            self?.levelsList.append(levelObj)
                            if index == 1 {
                                self?.currentLevelsArrayIndex = 0
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
        if index >= 0 && index < levelsList[currentLevelsArrayIndex].questionsList.count {
            return levelsList[currentLevelsArrayIndex].questionsList[index]
        }
        return nil
    }
    
}
