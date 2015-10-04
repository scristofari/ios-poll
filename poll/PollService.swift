//
//  PollService.swift
//  poll
//
//  Created by Sylvain Cristofari on 10/08/2015.
//  Copyright (c) 2015 Sylvain Cristofari. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

// MARK: req
class ListPollsReq : Mappable {
    
    var polls: [Poll]?
    var next: String?
    var kind: String?
    var etag: String?
    
    class func newInstance() -> Mappable {
        return ListPollsReq()
    }
    
    func mapping(map: Map) {
        polls <- map["polls"]
        next  <- map["next"]
        kind  <- map["kind"]
        etag  <- map["etag"]
    }
}

// MARK: Rest api service
class PollService {
    
    let BASE_URL = "https://acropoll-gae.appspot.com/_ah/api/sparck/v1/"
    
    func getPolls(completion: (response: ListPollsReq?, error: NSError?) -> Void) {
        Alamofire.request(.GET, BASE_URL + "polls", parameters: nil)
            .responseObject { (response: ListPollsReq?, error: NSError?) in
                completion(response: response, error: error)
        }
    }
}
