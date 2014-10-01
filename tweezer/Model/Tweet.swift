//
//  Tweet.swift
//  tweezer
//
//  Created by Sam Mueller on 9/30/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import Foundation

class Tweet {
    var id: Int
    var text: String?
    var user: User!
    var favoriteCount: Int
    var retweetCount: Int
    var isRetweet: Bool
    var retweetMessage: String?
    
    init(dictionary: NSDictionary) {
        println(dictionary)
        id = dictionary["id"] as Int
        if let retweetStatus = dictionary["retweeted_status"] as? NSDictionary {
            isRetweet = true
            var userHash = retweetStatus["user"] as NSDictionary
            var retweetUser = userHash["screen_name"]! as String
            retweetMessage = "Retweeted by @\(retweetUser)"
        } else {
            isRetweet = false
        }
        
        text = dictionary["text"] as? String
        favoriteCount = dictionary["favorite_count"] as Int
        retweetCount = dictionary["retweet_count"] as Int
        if let user = dictionary["user"] as? NSDictionary {
            self.user = User(dictionary: user)
        }
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}