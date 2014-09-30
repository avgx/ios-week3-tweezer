//
//  TimelineViewController.swift
//  tweezer
//
//  Created by Sam Mueller on 9/29/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController {
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.getTimeline({ (data: [Tweet]) in
            self.tweets += data
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell", forIndexPath: indexPath) as TimelineCell
        cell.forTweet(tweets[indexPath.row])

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ComposeTweet" {
            let nc = segue.destinationViewController as UINavigationController
            let vc = nc.viewControllers[0] as ComposeViewController
            vc.forTweet(nil, { (tweet: Tweet?) in
                if tweet != nil {
                    self.tweets.insert(tweet!, atIndex: 0)
                }
                
                self.tableView.reloadData()
            })
        }
    }

}
