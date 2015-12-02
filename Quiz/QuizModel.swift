//
//  QuizModel.swift
//  Quiz
//
//  Created by Christopher Ching on 2014-11-18.
//  Copyright (c) 2014 CodeWithChris. All rights reserved.
//

import UIKit

class QuizModel: NSObject {
   
    func getQuestions() -> [Question] {
        
        // Array of question objects
        var questions:[Question] = [Question]()
        
        // Get Json array of dictionaries
        let jsonObjects:[NSDictionary] = self.getRemoteJsonFile()
        
        // Loop through each dictionary and assign values to our question objs
        var index:Int
        for index = 0; index < jsonObjects.count; index++ {
            
            // Current JSON dict
            let jsonDictionary:NSDictionary = jsonObjects[index]
            
            // Create a question obj
            var q:Question = Question()
            
            // Assign the values of each key value pair to the question object
            q.questionText = jsonDictionary["question"] as! String
            q.answers = jsonDictionary["answers"] as! [String]
            q.correctAnswerIndex = jsonDictionary["correctIndex"] as! Int
            q.module = jsonDictionary["module"] as! Int
            q.lesson = jsonDictionary["lesson"] as! Int
            q.feedback = jsonDictionary["feedback"] as! String
            
            // Add the question to the question array
            questions.append(q)
        }
        
        // Return list of question objects        
        return questions
    }
    
    func getRemoteJsonFile() -> [NSDictionary] {
        
        // Create a new URL
        let remoteUrl:NSURL? = NSURL(string: "http://codewithchris.com/code/QuestionData.json")
        
        // Check if it's nil
        if let actualRemoteUrl = remoteUrl {
            
            // Try to get the data
            let fileData:NSData? = NSData(contentsOfURL: actualRemoteUrl)
            
            // Check if it's nil
            if let actualFileData = fileData {
                
                // Parse out the dictionaries
                do {
                    
                    let arrayOfDictionaries:[NSDictionary] = try NSJSONSerialization.JSONObjectWithData(actualFileData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
 
                    // Successfully parsed out array of dictionaries
                    return arrayOfDictionaries
                    
                }
                catch {
                    // This code is run if an error is thrown
                }

            }
            
        }
        return [NSDictionary]()
    }
    
    func getLocalJsonFile() -> [NSDictionary] {
        
        // Get an NSURL obj pointing to the json file in our app bundle
        let appBundlePath:String? = NSBundle.mainBundle().pathForResource("QuestionData", ofType: "json")
        
        // Use optional binding to check if path exists
        if let actualBundlePath = appBundlePath {
            
            // Bundle path exists
            let urlPath:NSURL? = NSURL(fileURLWithPath: actualBundlePath)
            
            if let actualURLPath = urlPath {
                
                // NSURL obj was created, now create the NSData obj
                let jsonData:NSData? = NSData(contentsOfURL: actualURLPath)
                
                if let actualJsonData = jsonData {
                    
                    // NSData exists, use the NSJSONSerialization classes to parse the data and create the array/dictionaries
                    
                    do {
                        
                    let arrayOfDictionaries:[NSDictionary] = try NSJSONSerialization.JSONObjectWithData(actualJsonData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                        
                        // Successfully parsed out array of dictionaries
                        return arrayOfDictionaries
                    }
                    catch {
                        // This code is run if an error is thrown
                    }
                    
                }
                
            }
            
        }
        
        return [NSDictionary]()
        
    }
}
