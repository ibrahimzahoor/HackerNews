//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        
        var currentUser = PFUser.currentUser()?.username
        
        if currentUser != nil {
            
            self.performSegueWithIdentifier("JumpToNewsFeed", sender: self)
            
        } else {
            
            let logInViewController = CustomLogInViewController()
            logInViewController.delegate = self
            logInViewController.fields = (PFLogInFields.UsernameAndPassword
                | PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton)
            
            let signUpViewController = CustomSignUpViewController()
            signUpViewController.delegate = self
            signUpViewController.fields = (PFSignUpFields.UsernameAndPassword
                | PFSignUpFields.SignUpButton
                | PFSignUpFields.DismissButton)
            
            logInViewController.signUpController = signUpViewController
            presentViewController(logInViewController, animated: true, completion: nil)
            
        }
        
    }
    
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : PFLogInViewControllerDelegate {
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
}

extension ViewController : PFSignUpViewControllerDelegate {
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}

