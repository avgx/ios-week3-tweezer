//
//  User.swift
//  tweezer
//
//  Created by Sam Mueller on 9/30/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import Foundation

class User {
    
    private var _username = ""
    
    var name: String
    
    var username: String {
        get {
            return _username
        }
        set {
            _username = "@\(newValue)"
        }
    }
    
    var profileImageUrl: String = ""
    
    init(dictionary: NSDictionary) {
        
        name = dictionary["name"] as String
        username = dictionary["screen_name"] as String
        profileImageUrl = dictionary["profile_image_url"] as String
    }
}
