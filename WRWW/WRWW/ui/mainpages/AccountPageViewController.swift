//
//  SettingsPageViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/27/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit
import LoopBack
import Locksmith

class AccountPageViewController : UIViewController {
    
    
    @IBAction func onLogoutPressed(sender: AnyObject) {
        AppDelegate.userAccountRepository.logoutWithSuccess({
            
            // Delete from the keychain and transition back to the login screen
            do {
                try Locksmith.deleteDataForUserAccount("WRWW")
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("LoginUserViewController")
                
                self.navigationController?.setViewControllers([mainVC], animated: true)
            } catch _ {
                
            }
            
        }) { (err:NSError!) in
            print(err)
        }
    }
    
}