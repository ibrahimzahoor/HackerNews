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
    
    
    
    /*var signupActive = true
    
    func displayAlert(title: String, error: String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupButtonText: UIButton!
    
    @IBAction func signupButtonClick(sender: AnyObject) {
    
        var error = ""
        
        if username.text == "" || password.text == ""
        {
            error = "Please Enter Username and Password"
        }
        
        
        if error != ""
        {
            displayAlert("Error in Form", error: error)
        }
        else
        {
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, signupError: NSError?) -> Void in
                
                    if signupError == nil {
                        
                        self.performSegueWithIdentifier("JumpToNewsFeed", sender: self)
                        
                    }
                    else {
                
                        if let errorString = signupError!.userInfo?["error"] as? String {
                            error = errorString
                    
                        }
                        else {
                
                            error = "Please try again later."
                        }
        
                        self.displayAlert("Could Not Sign Up", error: error)
                    }
                }
            }
            else {
                
                PFUser.logInWithUsernameInBackground(username.text, password: password.text) {
                    (user: PFUser?, signupError: NSError?) -> Void in
                    if signupError == nil {
                        self.performSegueWithIdentifier("JumpToNewsFeed", sender: self)
                    }
                    else {
                        
                        if let errorString = signupError!.userInfo?["error"] as? String {
                            error = errorString
                            
                        }
                        else {
                            
                            error = "Please try again later."
                        }
                        
                        self.displayAlert("Could Not Log In", error: error)
                    }

                }
            }
        }
    }
    
    
    
    @IBOutlet weak var alreadyregisteredText: UILabel!
    
    @IBOutlet weak var loginButtonText: UIButton!
    
    @IBAction func loginButtonClick(sender: AnyObject) {
    
        if signupActive == true {
            
            signupActive = false
            
            titleText.text = "Use the following form to Log In"
            
            signupButtonText.setTitle("Log In", forState: UIControlState.Normal)
            
            alreadyregisteredText.text = "Not Registered"
            
            loginButtonText.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        else {
            
            signupActive = true
            
            titleText.text = "Use the following form to Sign In"
            
            signupButtonText.setTitle("Sign In", forState: UIControlState.Normal)
            
            alreadyregisteredText.text = "Already Registered"
            
            loginButtonText.setTitle("Log In", forState: UIControlState.Normal)
            
        }
    
    
    }*/
    

    
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

