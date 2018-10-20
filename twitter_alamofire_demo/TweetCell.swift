//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Hamsika Pongubala on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel

class TweetCell: UITableViewCell {


  @IBOutlet weak var userIconImageView: UIImageView!
  @IBOutlet weak var userNameLabel: TTTAttributedLabel!
  @IBOutlet weak var userHandleLabel: TTTAttributedLabel!
  @IBOutlet weak var dateLabel: TTTAttributedLabel!
  @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!
  
  
  @IBOutlet weak var favoriteLabel: TTTAttributedLabel!
    @IBOutlet weak var retweetLabel: TTTAttributedLabel!
  
  
  @IBOutlet weak var favoriteButton: UIButton!
  
  @IBOutlet weak var retweetButton: UIButton!
  
    var favorited: Bool?
    var retweeted: Bool?
    var imageString: String = ""
  
    var tweet: Tweet!{
      
          didSet{
            
            userNameLabel.setText(tweet.user.name)
            userHandleLabel.setText("@"+(tweet.user.screenName)!)
            imageString = tweet.user.profileImageUrl!
            let imageURL = URL(string: self.imageString)!
            userIconImageView.af_setImage(withURL: imageURL)
            
            tweetTextLabel.text = tweet.text
            favorited = tweet.favorited!
            retweeted = tweet.retweeted
            updateUI()
            
            
      }
    }
  
  
  
  @IBAction func favoriteOnTap(_ sender: Any) {
    
      if tweet.favorited == false {
            tweet.favorited = true
            favoriteTweet()
        } else {
            tweet.favorited = false
            unfavoriteTweet()
        }
        updateUI()
  }
  
  @IBAction func retweetOnTap(_ sender: Any) {
    
      if tweet.retweeted == false {
            tweet.retweeted = true
            retweetTweet()
        } else {
            tweet.retweeted = false
            unretweetTweet()
        }
        updateUI()
  
  }
  
  
    func updateUI() {
        //Tweets Favorited case
        if tweet.favorited == true {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        //Tweets Retweeted case
        if tweet.retweeted == true {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        if tweet.retweetCount > 0 {
            retweetLabel.text = "\(tweet.retweetCount)"
        } else {
            retweetLabel.text = ""
        }
        if tweet.favoriteCount! > 0 {
            favoriteLabel.text = "\(tweet.favoriteCount!)"
        } else {
            favoriteLabel.text = ""
        }
    }

      func favoriteTweet() {
        APIManager.shared.unfavorite(tweet: tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoriteLabel.text = "\(tweet.favoriteCount! + 1)"
                self.updateUI()
            }
          }
      }
  
      func unfavoriteTweet() {
        APIManager.shared.unfavorite(tweet: tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                tweet.favorited = false
                self.favoriteLabel.text = "\(tweet.favoriteCount! - 1)"
                self.updateUI()
            }
          }
      }
  
      func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                tweet.retweetCount += 1
                self.updateUI()
            }
        }
      }
  
    func unretweetTweet() {
        APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error untweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                tweet.retweeted = false
                tweet.retweetCount -= 1
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
