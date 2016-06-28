//
//  AppDelegate.swift
//  WRWW
//
//  Created by John Swensen on 6/15/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

import LoopBack
import Locksmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let adapter = LBRESTAdapter(URL: NSURL(string: "http://localhost:3000/api/"))
    static let wardrobeUserRepository = adapter.repositoryWithClass(WardrobeUserRepository) as! WardrobeUserRepository
    
    static let userClosetRepository = adapter.repositoryWithClass(UserClosetRepository) as! UserClosetRepository
    static let userClosetItemRepository = adapter.repositoryWithClass(UserClosetItemRepository) as! UserClosetItemRepository

    static let userOutfitRepository = adapter.repositoryWithClass(UserOutfitRepository) as! UserOutfitRepository
    static let userOutfitItemRepository = adapter.repositoryWithClass(UserOutfitItemRepository) as! UserOutfitItemRepository
    
    static let userAccountRepository = adapter.repositoryWithClass(UserRepository) as! UserRepository
    
    static var userId:String? = nil
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let _ = AppDelegate.wardrobeUserRepository
        let _ = AppDelegate.userClosetRepository
        let _ = AppDelegate.userClosetItemRepository
        let _ = AppDelegate.userOutfitRepository
        let _ = AppDelegate.userOutfitItemRepository
        let _ = AppDelegate.userAccountRepository
        
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handled
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

