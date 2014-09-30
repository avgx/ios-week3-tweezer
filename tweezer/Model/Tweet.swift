//
//  Tweet.swift
//  tweezer
//
//  Created by Sam Mueller on 9/30/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import Foundation

class Tweet {
    var text: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}