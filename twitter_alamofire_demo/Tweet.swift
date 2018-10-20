//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import DateToolsSwift

class Tweet: NSObject {
  
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
  
    var createdAtString: String // Display date
    var timeAgoSinceNow: String // Display when tweet was created
  
    var user: User // Contains name, screenname, etc. of tweet author

  
  
    init(dictionary: [String : Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
      
        //User Object Initialization
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
      
        //Date initialization
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        timeAgoSinceNow = date.shortTimeAgoSinceNow
        createdAtString = date.format(with: "M/d/yy, HH:mm a")

    }
}
