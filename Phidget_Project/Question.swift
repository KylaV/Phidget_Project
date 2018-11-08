//
//  Question.swift
//  Phidget_Project
//
//  Created by Kyla Vidallo on 2018-11-08.
//  Copyright © 2018 Kyla Vidallo. All rights reserved.
//

import Foundation

class Question {
    let questionText: String
    let answer: Bool
    
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
}
