//
//  TimelineCell.swift
//  tweezer
//
//  Created by Sam Mueller on 9/30/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var retweeted: UILabel!
    @IBOutlet weak var retweetedIcon: UIImageView!
    @IBOutlet weak var elapsed: UILabel!
    @IBOutlet weak var retweetIconHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetedHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumb.layer.cornerRadius = thumb.frame.size.width / 2;
        thumb.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func forTweet(tweet: Tweet) {
        status.text = tweet.text
        fullname.text = tweet.user.name
        username.text = tweet.user.username
        thumb.setImageWithURL(NSURL(string: tweet.user.profileImageUrl))
        retweetIconHeightContstraint.constant = tweet.isRetweet ? retweetIconHeightContstraint.constant : 0
        retweetedHeightConstraint.constant = tweet.isRetweet ? retweetedHeightConstraint.constant : 0
        retweeted.text = tweet.retweetMessage
    }

}
