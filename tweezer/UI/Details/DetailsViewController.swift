//
//  DetailsViewController.swift
//  tweezer
//
//  Created by Samuel Mueller on 9/30/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumb.layer.cornerRadius = thumb.frame.size.width / 2;
        thumb.clipsToBounds = true
        
        thumb.setImageWithURL(NSURL(string: tweet!.user.profileImageUrl))
        fullname.text = tweet!.user.name
        username.text = tweet!.user.username
        status.text = tweet!.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true    )
    }
    
    func forTweet(tweet: Tweet) {
        self.tweet = tweet
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ComposeFromDetail" {
            let nc = segue.destinationViewController as UINavigationController
            let vc = nc.viewControllers[0] as ComposeViewController
            vc.forTweet(tweet!, { (tweet: Tweet?) in
//                if tweet != nil {
//                    self.tweets.insert(tweet!, atIndex: 0)
//                }
//                
//                self.tableView.reloadData()
            })
        }
    }
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!, completion: {})
    }
}
