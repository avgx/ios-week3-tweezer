//
//  TwitterClient.swift
//  tweezer
//
//  Created by Samuel Mueller on 9/29/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import Foundation

private let key = "Zf5uTxkdQjWFHnnUMNsDmVZO3"
private let secret = "e9XB52PvFXCVWVlyA7y7cP4MnDNsRoZNHPUmUoosyi2F9reKC4"
private let host = "https://api.twitter.com"

class TwitterClient : BDBOAuth1SessionManager {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var isLoggedIn: Bool {
        get {
            println("isLoggedIn: checking for accessToken \(requestSerializer.accessToken)")
            return requestSerializer.accessToken != nil
        }
    }
    
    func login(completion: (url: String) -> Void) {
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweezer://oauth"), scope: nil, success: { (requestToken:BDBOAuthToken!) -> Void in
            println("got token")
            completion(url: "\(host)/oauth/authorize?oauth_token=\(requestToken.token)")
        }) { (error: NSError!) -> Void in
            print("error - login: \(error)")
        }
    }
    
    func setAuthToken(query: String, completion: () -> Void) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: query), success: { (token: BDBOAuthToken!) -> Void in
            completion()
            self.requestSerializer.saveAccessToken(token)
        }) { (error: NSError!) -> Void in
                print("error - set auth token: \(error)")
        }
    }
    
    func getCurrentUser() {
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (session: NSURLSessionDataTask!, response: AnyObject!) -> Void in
            println(response)
        }) { (session: NSURLSessionDataTask!, error: NSError!) -> Void in
            print("error - get current user: \(error)")
        }
    }
    
    func getTimeline(completion: (data: [Tweet]) -> Void) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (session: NSURLSessionDataTask!, response: AnyObject!) -> Void in
            completion(data:Tweet.tweetsFromArray(response as [NSDictionary]))
        }) { (session: NSURLSessionDataTask!, error: NSError!) -> Void in
            var errorData = error.userInfo!["com.alamofire.serialization.response.error.data"] as NSData
            var json = NSJSONSerialization.JSONObjectWithData(errorData, options: nil, error: nil)!
            println(json)
        }
    }
    
    func retweet(tweet: Tweet, completion: () -> Void) {
        var url = "1.1/statuses/retweet/\(tweet.id).json"
        println(url)
        POST(url, parameters: nil, success: { (session: NSURLSessionDataTask!, response: AnyObject!) -> Void in
            completion()
            println("success retweet")
        }) { (session: NSURLSessionDataTask!, error: NSError!) -> Void in
            print("error - post retweet: \(error)")
        }
    }
    
    func postTweet(status: String, completion: (data: Tweet) -> Void) {
        var params = Dictionary<String, String>()
        params["status"] = status
        POST("1.1/statuses/update.json", parameters: params, success: { (session: NSURLSessionDataTask!, response: AnyObject!) -> Void in
            completion(data: Tweet(dictionary: response as NSDictionary))
            println("success tweet")
        }) { (session: NSURLSessionDataTask!, error: NSError!) -> Void in
            print("error - post tweet: \(error)")
        }
    }
    
    func logout() {
        
        self.requestSerializer.removeAccessToken()
    }

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: NSURL(string: host), consumerKey: key, consumerSecret: secret)
        }
        
        return Static.instance
    }
}