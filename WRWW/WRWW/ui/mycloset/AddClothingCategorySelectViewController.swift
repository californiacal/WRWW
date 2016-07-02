//
//  AddClothingCategorySelectViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/28/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

class AddClothingCategorySelectViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryStrings:[String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Create the full color button for the toolbar
        let image1:UIImage? = self.topToolbar.items![(self.topToolbar.items?.count)!-2].image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem1:UIBarButtonItem? = UIBarButtonItem(image: image1, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddClothingCategorySelectViewController.onHelpBarItem))
        
        
        let image2:UIImage? = self.topToolbar.items![(self.topToolbar.items?.count)!-1].image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem2:UIBarButtonItem? = UIBarButtonItem(image: image2, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddClothingCategorySelectViewController.onCloseBarItem))
        
        // Replace the last item with the full-color item
        var pp = self.topToolbar.items
        pp![(pp?.count)!-2] = barItem1!
        pp![(pp?.count)!-1] = barItem2!
        self.topToolbar.setItems(pp, animated: false)
        
        // Query the list of closet categories
        AppDelegate.userClosetRepository.allWithSuccess({ (closets:[AnyObject]!) in
            
            var categoryArray:[String]? = []
            
            for  closet in closets as! [UserCloset] {
                categoryArray?.append(closet.closet_name)
            }
            
            self.categoryStrings = categoryArray
            self.categoryTableView.reloadData()
            
        }) { (err:NSError!) in
            print(err)
        }
    }
    
    func onHelpBarItem(sender: AnyObject) {
        // Add the help popup
        let alertViewIcon = UIImage(named: "Help")
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Gotham Medium", size: 20)!,
            kTextFont: UIFont(name: "Gotham Light", size: 14)!,
            kButtonFont: UIFont(name: "Gotham Medium", size: 14)!,
            showCloseButton: true,
            showCircularIcon: true,
            kCircleHeight: (alertViewIcon?.size.height)!,
            kCircleIconHeight: (alertViewIcon?.size.height)!
        )
        
        
        let alertView = SCLAlertView(appearance: appearance)
        
        
        alertView.showInfo("Help", subTitle: "You are now adding real clothing from your wardrobe. You will be asked to photograph your clothing and accessories. You can later use these items to put together complete outfits, save your outfits, share with friends, sell, trade, or donate items! First, select the type of clothing you would like to add.", closeButtonTitle: "Got It!", duration: 0, colorStyle: 0xFFFFFF, colorTextButton: 0xE4327B, circleIconImage: alertViewIcon)
    }
    
    func onCloseBarItem(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categoryStrings?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.categoryTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.categoryStrings![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "MyCloset", bundle: nil)
        let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("ImageCaptureClothingViewController")
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
}