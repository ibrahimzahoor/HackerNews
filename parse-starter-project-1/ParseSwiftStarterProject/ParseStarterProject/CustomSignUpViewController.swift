//
//  CustomSignUpViewController.swift
//  Hacker News
//
//  Created by ibrahim on 31/07/2015.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import ParseUI

class CustomSignUpViewController: PFSignUpViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let label = UILabel()
        label.textColor = UIColor.blueColor()
        label.text = "Hacker News"
        signUpView?.logo = label
        
        
        
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
