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
import LoopBack

class FirstViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    @IBAction func onButtonPressed(sender: AnyObject) {

        // Example of inserting an new item in the user_closet table
//        let closet:UserCloset = UserCloset(repository: AppDelegate.userClosetRepository, parameters: nil)
//        //closet.repository = AppDelegate.userClosetRepository
//        
//        closet.owner_id = Int(AppDelegate.userId!)
//        closet.closet_name = "My First Closet"
//        closet.wardrobe_type_id = 0
//        closet.privacy_level_id = 0
//        closet.user_location_id = 0
//        closet.create_date = NSDate()
//        closet.delete_datetime = nil
//        
//        closet.saveWithSuccess({
//            print("Success saving closet")
//        }) { (err:NSError!) in
//            print("Error saving closet")
//            print(err)
//        }
        
        // Retrieve all the user closet items
//        AppDelegate.userClosetRepository.allWithSuccess({ (fetchedUserClosets:[AnyObject]!) in
//            let userClosets = fetchedUserClosets as! [UserCloset]
//            for userCloset:UserCloset in userClosets
//            {
//                print(userCloset)
//            }
//        }) { (err:NSError!) in
//            print(err)
//        }
        
        
        
        // Retrieve a limited list with includes
        AppDelegate.userClosetRepository.findWithFilter(["where":["id":3],"include":"user_closet_items"], success: { (objectList:[AnyObject]!) in
            print(objectList)
            if let closets = objectList as? [UserCloset] {
                for closet in closets {
                    print(closet)
                    
                    
                    //let closetItem:UserClosetItem = AppDelegate.userClosetItemRepository.modelWithDictionary(closet.user_closet_items![1] as [NSObject : AnyObject]) as! UserClosetItem
                    //print(closetItem)
                    
                }
            }
        }) { (err:NSError!) in
            print(err)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        
        
        
        
        //AppDelegate.userOutfitRepository.findWithFilter(<#T##filter: [NSObject : AnyObject]!##[NSObject : AnyObject]!#>, success: <#T##LBPersistedModelAllSuccessBlock!##LBPersistedModelAllSuccessBlock!##([AnyObject]!) -> Void#>, failure: <#T##SLFailureBlock!##SLFailureBlock!##(NSError!) -> Void#>)
        
        //        let userAccount : User = AppDelegate.userAccountRepository.createUserWithEmail("jpswensen@hotmail.com", password: "pickles") as! User
        //        userAccount.saveWithSuccess({
        //            AppDelegate.userAccountRepository.loginWithEmail(userAccount.email, password: userAccount.password, success: { (accessToken:LBAccessToken!) in
        //                print("Success")
        //                print(accessToken)
        //            }) { (err:NSError!) in
        //                print("Error on login to new user account")
        //                print(err)
        //            }
        //        }) { (err:NSError!) in
        //            print("Error on new user account save")
        //            print(err)
        //        }
        
        
//        AppDelegate.userAccountRepository.loginWithEmail("jpswensen@hotmail.com", password: "pickles", success: { (accessToken:LBAccessToken!) in
//            print("Success")
//            print(accessToken)
//            AppDelegate.userAccountRepository.findById(2, success: { (model:LBPersistedModel!) in
//                print(model)
//            }) { (err:NSError!) in
//                print (err)
//            }
//            
//        }) { (err:NSError!) in
//            print("Error on login to new user account")
//            print(err)
//        }
        
        
        //        AppDelegate.contentUserRepository.allWithSuccess({ (fetchedContentUsers: [AnyObject]!) -> Void in
        //            self.contentUsers = fetchedContentUsers as! [ContentUser]
        //            for contentUser:ContentUser in self.contentUsers
        //            {
        //                print(contentUser.first_name)
        //            }
        //        }) { (error: NSError!) -> Void in
        //            NSLog(error.description)
        //        }
        //
        //        let cu:ContentUser = AppDelegate.contentUserRepository.model() as! ContentUser
        //        cu.first_name = "Apple"
        //        cu.last_name = "Computer"
        //        cu.saveWithSuccess({
        //            print("Success")
        //        }) { (error:NSError!) in
        //            print("Error")
        //        }
        
        
        
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

