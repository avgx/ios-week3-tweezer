//
//  ComposeViewController.swift
//  tweezer
//
//  Created by Sam Mueller on 9/29/14.
//  Copyright (c) 2014 Sam Mueller. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var status: UITextView!
    var completion: ((tweet: Tweet?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onCancel(sender: AnyObject) {
        self.closeAndCallback(nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.postTweet(status.text, completion: { (data) -> Void in
            self.closeAndCallback(data)
        })
    }
    
    //will return a nil repository if modal was canceled
    func forTweet(initialStatus: String?, completion: ((tweet: Tweet?) -> Void)) {
        self.completion = completion
    }
    
    func closeAndCallback(tweet: Tweet?) {
        dismissViewControllerAnimated(true, { })
        if let c = completion {
            c(tweet: tweet)
        }
    }
}
