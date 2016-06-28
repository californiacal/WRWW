//
//  CreateUserViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/22/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit
import TTTAttributedLabel
import LoopBack
import Locksmith

class LoginUserViewController : UIViewController, TTTAttributedLabelDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var signupLabel : TTTAttributedLabel?
    @IBOutlet weak var recoverLabel : TTTAttributedLabel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        
        let linkColor = UIColor.blueColor()
        let linkActiveColor = UIColor.blueColor()
        
        // Set up the sign up label
        self.signupLabel?.numberOfLines = 2
        self.signupLabel!.delegate = self
        signupLabel!.linkAttributes = [kCTForegroundColorAttributeName : linkColor.CGColor,kCTUnderlineStyleAttributeName : NSNumber(bool: true)]
        signupLabel!.activeLinkAttributes = [NSForegroundColorAttributeName : linkActiveColor]
        signupLabel!.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        let signupLabelString = signupLabel!.text! as NSString
        let signupLabelRange  = signupLabelString.rangeOfString("SIGN UP")
        signupLabel?.addLinkToURL(NSURL(string:"SIGNUP"), withRange: signupLabelRange)
        
        // Set up the recover username and password label
        self.recoverLabel?.numberOfLines = 2
        self.recoverLabel!.delegate = self
        recoverLabel!.linkAttributes = [kCTForegroundColorAttributeName : linkColor.CGColor,kCTUnderlineStyleAttributeName : NSNumber(bool: true)]
        recoverLabel!.activeLinkAttributes = [NSForegroundColorAttributeName : linkActiveColor]
        recoverLabel!.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        let recoverLabelString = recoverLabel!.text! as NSString
        let recoverLabelRange  = recoverLabelString.rangeOfString("Forgot Your Username or Password?")
        recoverLabel?.addLinkToURL(NSURL(string:"http://www.swengames.com"), withRange: recoverLabelRange)
        
        do {
            
            let dictionary = Locksmith.loadDataForUserAccount("WRWW") as NSDictionary?
            print(dictionary)
            if dictionary != nil {
                self.loginToUserAccount(dictionary?.valueForKey("username") as! String, password: dictionary?.valueForKey("password") as! String)
            }
        }
    }
    
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        
        if url.absoluteString == "SIGNUP"
        {
            print("SIGNUP link pressed")
            
            // FIXME: Transition to a login screen instead of an account creation screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("CreateUserViewController")
            
            self.navigationController?.setViewControllers([mainVC], animated: true)
        }
        else
        {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    @IBAction func onSignupPressed(sender: AnyObject) {
        // Validate the fields. If not correct, then show the error
        
        if !((emailTextField.text?.isEmail)!)
        {
            let color = UIColor.redColor()
            emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail Address Required", attributes: [NSForegroundColorAttributeName:color])
            
        }
        if passwordTextField.text?.characters.count < 6
        {
            let color = UIColor.redColor()
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "6 Digit Password Required", attributes: [NSForegroundColorAttributeName:color])
        }
        
        
        // If all are satisfied, then let's make an API call to create the user account
        if (emailTextField.text?.isEmail)! &&
           passwordTextField.text?.characters.count >= 6
        {
            self.loginToUserAccount(self.emailTextField.text!, password: self.passwordTextField.text!)
        }
        
    }

    func loginToUserAccount(account:String, password:String)
    {
        AppDelegate.userAccountRepository.loginWithEmail(account, password: password, success: { (accessToken:LBAccessToken!) in
            print("Success")
            print(accessToken)
            
            if let result_number = accessToken.valueForKey("userId") as? NSNumber
            {
                AppDelegate.userId = "\(result_number)"
            }
            
            do {
                let dictionary = Locksmith.loadDataForUserAccount("WRWW")
                if dictionary == nil {
                    try Locksmith.saveData(["username": account, "password": password], forUserAccount: "WRWW")
                }
                else
                {
                    try Locksmith.updateData(["username": account, "password": password], forUserAccount: "WRWW")
                }
            } catch _ {
                
            }
            
            // FIXME: perform a post to create an entry in the content_user table with the correct phone number and owner_id as the foreign key for the User table
            
            
            // Only do this transition of the account creation succeeded
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("PrimaryTabBarViewController")
            
            self.navigationController?.setViewControllers([mainVC], animated: true)
            
        }) { (err:NSError!) in
            print("Error on login to user account")
            
            // create the alert
            let alert = UIAlertController(title: "User login error", message: "Unable to log in to user account.", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
            print(err)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
