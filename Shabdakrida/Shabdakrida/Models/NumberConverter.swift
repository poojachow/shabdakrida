//
//  NumberConverter.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/31/20.
//

import Foundation

class NumberConverter {
    
    static let numbersMap = [
        0: "०",
        1: "१",
        2: "२",
        3: "३",
        4: "४",
        5: "५",
        6: "६",
        7: "७",
        8: "८",
        9: "९"]
    
    class func getTranslatedNumber(number: Int) -> String {
        var result = ""
        let numArray = String(number)
        numArray.forEach { (char) in
            let tempResult = Int(String(char)) ?? -1
            if let translatedChar = numbersMap[tempResult] {
                result.append(translatedChar)
            }
        }
        return result
    }
}
