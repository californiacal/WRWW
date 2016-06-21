//
//  FirstViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/15/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import UIKit
import Alamofire

import FBSDKLoginKit

class FirstViewController: UIViewController, FBSDKLoginButtonDelegate {

    var contentUsers = [ContentUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        AppDelegate.contentUserRepository.allWithSuccess({ (fetchedContentUsers: [AnyObject]!) -> Void in
            self.contentUsers = fetchedContentUsers as! [ContentUser]
            for contentUser:ContentUser in self.contentUsers
            {
                print(contentUser.first_name)
            }
        }) { (error: NSError!) -> Void in
            NSLog(error.description)
        }
        
        let cu:ContentUser = AppDelegate.contentUserRepository.model() as! ContentUser        
        cu.first_name = "Apple"
        cu.last_name = "Computer"
        cu.saveWithSuccess({ 
            print("Success")
        }) { (error:NSError!) in
            print("Error")
        }
        
        
        
//        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//        // Optional: Place the button in the center of your view.
//        loginButton.center = self.view.center;
//        [self.view addSubview:loginButton];
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        //self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
        //self.loginView.delegate = self;
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil
        {
            // TODO: Implement the upsert into the content_user table
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }

}

