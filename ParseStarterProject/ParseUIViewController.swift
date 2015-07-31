//
//  ParseUIViewController.swift
//  Hacker News
//
//  Created by ibrahim on 30/07/2015.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ParseUIViewController: PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var logInController = PFLogInViewController()
        logInController.delegate = self as? PFLogInViewControllerDelegate
        self.presentViewController(logInController, animated:true, completion: nil)
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
