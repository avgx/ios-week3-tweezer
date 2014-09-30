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
    var name: String?
    var username: String?
    var profileImageUrl: String?
    
    init(dictionary: NSDictionary) {
        println(dictionary)
        text = dictionary["text"] as? String
        var user = dictionary["user"] as NSDictionary
        name = user["name"] as? String
        username = user["screen_name"] as? String
        profileImageUrl = user["profile_image_url"] as? String
        println(username)
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}