//
//  MyClosetViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/27/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import CollectionViewWaterfallLayout

class MyClosetViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  CollectionViewWaterfallLayoutDelegate {

    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var categorySelectionBar: UIButton!
    @IBOutlet weak var closetCollectionView: UICollectionView!
    
    let categoryDropdown = DropDown()
    
    func scaleImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    override func viewDidLoad() {
        
        // Create the full color button for the toolbar
        let image:UIImage? = UIImage(named: "Plus")
        let scaledImage = self.scaleImage(image!, targetSize: CGSize(width: 0.6*self.topToolbar.frame.height,height: 0.6*self.topToolbar.frame.height)).imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem:UIBarButtonItem? = UIBarButtonItem(image: scaledImage, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MyClosetViewController.onBarItem))
        
        // Replace the last item with the full-color item
        var pp = self.topToolbar.items
        pp![(pp?.count)!-1] = barItem!
        self.topToolbar.setItems(pp, animated: false)
        
        
        categoryDropdown.textFont = UIFont(name: "Gotham Light", size: 17.0)!
        categoryDropdown.anchorView = categorySelectionBar
        categoryDropdown.dataSource = ["Accessories", "Dresses", "Handbags"]
        categoryDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.categorySelectionBar.setTitle(item, forState: UIControlState.Normal)
            
            // FIXME: Conduct a new query based on the category type
            //  (1) Figure out the ID of the current closet category
            //  (2) If specific category
            //          UserClosetItems.findWithFilter("where", ["user_closet_id":ID, "owner_id":currentId])
            //  (3) If "All Clothing Categories"
            //          UserClosetItems.all
            
            //  (4) Take the results and reload the closetCollectionView
        }
        
        
        // Set up the waterfall layout
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.headerInset = UIEdgeInsetsMake(20, 0, 0, 0)
        layout.headerHeight = 0
        layout.footerHeight = 10
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.columnCount = 2
        
        self.closetCollectionView.collectionViewLayout = layout
        
        // Query the list of closet categories
        AppDelegate.userClosetRepository.allWithSuccess({ (closets:[AnyObject]!) in
            
            var categoryArray:[String]? = ["All Clothing Categories"]
            
            for  closet in closets as! [UserCloset] {
                categoryArray?.append(closet.closet_name)
            }
            
            self.categoryDropdown.dataSource = categoryArray!
            self.categoryDropdown.reloadAllComponents()
            
        }) { (err:NSError!) in
            print(err)
        }
    }
    
    @IBAction func onCategoryPressed(sender: AnyObject) {
        categoryDropdown.show()
    }
    
    func onBarItem(sender: AnyObject) {
        // Transition to a login screen instead of an account creation screen
        let storyboard = UIStoryboard(name: "MyCloset", bundle: nil)
        let mainVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("AddClothingCategorySelectViewController")
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    // MARK: UICollectionView data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ClosetCell? = collectionView.dequeueReusableCellWithReuseIdentifier("ClosetCell", forIndexPath: indexPath) as? ClosetCell
        
        cell?.centerLabel.font = UIFont(name: "Gotham Light", size: 17.0)
        cell?.centerLabel.text = "\(indexPath.row), \(indexPath.item)"
        cell?.backgroundColor = UIColor.whiteColor()
        
        return cell!
    }
    
    // MARK: UICollectionView delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: UICollectionViewFlowLayout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height:CGFloat = CGFloat(arc4random() % 150 + 150)
        return CGSize(width:collectionView.contentSize.width/4, height:height)
    }
    
}
