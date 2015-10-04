//
//  PollModel.swift
//
//  Created by Sylvain Cristofari on 02/08/2015.
//  Copyright (c) 2015 Sylvain Cristofari. All rights reserved.
//

import Foundation
import ObjectMapper

// Mark: Poll
class Poll: Mappable {
    
    var uid: String?
    var name: String?
    var question: String?
    var answers: [Answer]?
    var created: String?
    var updated: String?
    var status: Int?
    
    class func newInstance() -> Mappable {
        return Poll()
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
        name <- map["name"]
        question <- map["question"]
        answers <- map["answers"]
        created <- map["created"]
        updated <- map["updated"]
        status <- map["status"]
    }
}


// Mark: Answer
class Answer: Mappable {
    var answer: String?
    var votes: Int?
    
    class func newInstance() -> Mappable {
        return Answer()
    }
    
    func mapping(map: Map) {
        answer <- map["answer"]
        votes  <- map["votes"]
    }
}