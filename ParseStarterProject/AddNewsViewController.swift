//
//  AddNewsViewController.swift
//  Hacker News
//
//  Created by ibrahim on 27/07/2015.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class AddNewsViewController: UIViewController {

    func displayAlert(title: String, error: String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBOutlet weak var news: UITextField!
    
    @IBOutlet weak var newstitle: UITextField!
    
    @IBAction func AddNewsButton(sender: AnyObject) {
     
        var error = ""
        
        if news.text! == "" {
            error = "Please Enter the News"
        }
        else if newstitle.text == "" {
            error = "Please Enter Title"
        }
        
        if error != "" {
         
            self.displayAlert("Cannot Post News", error: error)
        }
        else {
            
            var post = PFObject(className: "News")
            post["Title"] = newstitle.text
            post["Description"] = news.text
            post["User"] = PFUser.currentUser()?.username
            
            post.saveEventually()
            
            var push = PFPush()
            push.setMessage("New News: " + newstitle.text)
            push.sendPushInBackground()
            
            self.performSegueWithIdentifier("BackToFeed", sender: self)
        }
        
        
    }
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
