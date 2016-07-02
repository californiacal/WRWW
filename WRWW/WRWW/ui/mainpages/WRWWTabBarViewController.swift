//
//  WRWWTabBarViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/30/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func scaleUIImageToSize(let size: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
}

class WRWWTabBarController : UITabBarController {

    override func viewDidLoad() {
        
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(AppDelegate.wrwwColor, size: CGSizeMake(tabBar.frame.width/4, tabBar.frame.height))
        
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)

//        for item:UITabBarItem in self.tabBar.items! {
//            item.image?.renderingMode = UIImageRenderingMode.AlwaysOriginal
//        }
    }
    
}
