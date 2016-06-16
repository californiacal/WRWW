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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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

