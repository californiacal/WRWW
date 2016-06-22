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

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        
        let charcter  = NSCharacterSet(charactersInString: "+-0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoinedByString("")
        return  self == filtered
        
    }
}

class CreateUserViewController : UIViewController, TTTAttributedLabelDelegate {
    
    @IBOutlet weak var loginLabel : TTTAttributedLabel?
    @IBOutlet weak var legalLabel : TTTAttributedLabel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        
        let linkColor = UIColor.blueColor()
        let linkActiveColor = UIColor.blueColor()
        
        // Set up the login label
        self.loginLabel?.numberOfLines = 2
        self.loginLabel!.delegate = self
        loginLabel!.linkAttributes = [kCTForegroundColorAttributeName : linkColor.CGColor,kCTUnderlineStyleAttributeName : NSNumber(bool: true)]
        loginLabel!.activeLinkAttributes = [NSForegroundColorAttributeName : linkActiveColor]
        loginLabel!.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        let loginLabelString = loginLabel!.text! as NSString
        let loginLabelRange  = loginLabelString.rangeOfString("LOG IN")
        loginLabel?.addLinkToURL(NSURL(string:"LOGIN"), withRange: loginLabelRange)
        
        // Set up the legal label
        self.legalLabel?.numberOfLines = 2
        self.legalLabel!.delegate = self
        legalLabel!.linkAttributes = [kCTForegroundColorAttributeName : linkColor.CGColor,kCTUnderlineStyleAttributeName : NSNumber(bool: true)]
        legalLabel!.activeLinkAttributes = [NSForegroundColorAttributeName : linkActiveColor]
        legalLabel!.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        let originalString = legalLabel!.text! as NSString
        let range  = originalString.rangeOfString("privacy policy & terms of service")
        legalLabel?.addLinkToURL(NSURL(string:"http://www.swengames.com"), withRange: range)
    }
    
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        
        if url.absoluteString == "LOGIN"
        {
            print("LOGIN link pressed")
            // FIXME: Transition to a login screen instead of an account creation screen
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
        if phoneTextField.text?.characters.count == 0 || !((phoneTextField.text?.isPhoneNumber)!)
        {
            let color = UIColor.redColor()
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "Mobile Phone Required", attributes: [NSForegroundColorAttributeName:color])
            
        }
        if passwordTextField.text?.characters.count < 6
        {
            let color = UIColor.redColor()
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "6 Digit Password Required", attributes: [NSForegroundColorAttributeName:color])
        }
        
        
        // If all are satisfied, then let's make an API call to create the user account
        if (emailTextField.text?.isEmail)! &&
           phoneTextField.text?.characters.count > 0 && (phoneTextField.text?.isPhoneNumber)! &&
           passwordTextField.text?.characters.count >= 6
        {
            
            // FIXME: Only do this transition of the account creation succeeded
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("PrimaryTabBarViewController")
            
            self.navigationController?.setViewControllers([mainVC], animated: true)
        }
        
    }

    
    
}