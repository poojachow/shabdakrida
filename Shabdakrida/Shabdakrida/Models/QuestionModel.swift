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
    let level: String
    
    init(imageUrl: String, options: [String], answer: String, level: String) {
        self.imageUrl = imageUrl
        self.options = options
        self.answer = answer
        self.level = level
    }
}
