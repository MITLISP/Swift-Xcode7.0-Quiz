//
//  Question.swift
//  Quiz
//
//  Created by Christopher Ching on 2014-11-18.
//  Copyright (c) 2014 CodeWithChris. All rights reserved.
//

import UIKit

class Question: NSObject {
   
    var questionText:String = ""
    var answers:[String] = [String]()
    var correctAnswerIndex:Int = 0
    var module:Int = 0
    var lesson:Int = 0
    var feedback:String = ""
}
