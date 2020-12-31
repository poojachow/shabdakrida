//
//  QuestionModel.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import Foundation

enum Level: Int {
    case level1 = 1
    case level2 = 2
}

class QuestionModel {
    let imageUrl: String
    let options: [String]
    let answer: String
    
    init(imageUrl: String, options: [String], answer: String) {
        self.imageUrl = imageUrl
        self.options = options
        self.answer = answer
    }
}

// Mock code
fileprivate let q1 = QuestionModel(imageUrl: "https://i.pinimg.com/originals/e1/dc/57/e1dc574a122ee009c1bb8571a4981c8b.png", options: ["मल्लक", "केशाः", "लोचन", "नखर"], answer: "लोचन")
fileprivate let q2 = QuestionModel(imageUrl: "https://library.kissclipart.com/20190224/wwq/kissclipart-dog-clipart-puppy-maltese-dog-beagle-3400a99cc8df2422.png", options: ["श्वान", "बिडाला", "मूषक", "पीवन्"], answer: "श्वान")

let questions = [q1, q2]
