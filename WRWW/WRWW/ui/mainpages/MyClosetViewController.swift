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
    
    override func viewDidLoad() {
        
        // Create the full color button for the toolbar
        let image:UIImage? = UIImage(named: "Plus")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem:UIBarButtonItem? = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MyClosetViewController.onBarItem))
        
        // Replace the last item with the full-color item
        var pp = self.topToolbar.items
        pp![(pp?.count)!-1] = barItem!
        self.topToolbar.setItems(pp, animated: false)
        
        
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
        
        cell?.centerLabel.text = "\(indexPath.row), \(indexPath.item)"
        cell?.backgroundColor = UIColor.redColor()
        
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
