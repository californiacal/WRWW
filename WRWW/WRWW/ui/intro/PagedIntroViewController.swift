//
//  PagedIntroViewController.swift
//  WRWW
//
//  Created by John Swensen on 6/21/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit

class PagedIntroViewController : UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBOutlet weak var pageControl : UIPageControl?
    @IBOutlet weak var pageTextLabel : UILabel?
    weak var pagedViewController: UIPageViewController?
    
    var pages = [UIViewController]()
    var pagesText = [String]()
    
    override func viewDidLoad() {
        
        // Get local access to the UIPageViewController from the storyboard
        self.pagedViewController = self.childViewControllers[0] as? UIPageViewController
        self.pagedViewController?.delegate = self
        self.pagedViewController?.dataSource = self
        print(self.pagedViewController)
        
        // Load the viewcontroller pages from the Intro.storyboard
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        let page1: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page1")
        let page2: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page2")
        let page3: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page3")
        let page4: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page4")
        let page5: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page5")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        self.pagedViewController!.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        // Set up the text that should be shown on each page
        pagesText.append("Create Outfits, Trade & Sell Your Clothing")
        pagesText.append("Photograph & add clothing from your closet")
        pagesText.append("Combine your clothing to save your favorite outfits")
        pagesText.append("Trade & Sell your clothing with members & friends")
        pagesText.append("Get social! Comment, like & message with friends")
        
        
        // Configure the page control
        self.pageControl?.currentPage = 0
        self.pageControl?.pageIndicatorTintColor = UIColor.darkGrayColor()
        self.pageControl?.currentPageIndicatorTintColor = AppDelegate.wrwwColor
        self.pageControl?.numberOfPages = pages.count
        
        // Configure the page label
        self.pageTextLabel?.numberOfLines = 0
        self.pageTextLabel?.text = pagesText[0]
        
        // Set up the Get Started button
        getStartedButton.layer.cornerRadius = getStartedButton.frame.height/2
        getStartedButton.layer.borderWidth = 0
        getStartedButton.layer.borderColor = UIColor.clearColor().CGColor
    }
    

    // MARK: Delegate functions
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        let currentPage = pageViewController.viewControllers![0]
        let currentIndex = pages.indexOf(currentPage)!
     
        self.pageControl?.currentPage = currentIndex
        
        
        UIView.animateWithDuration(0.4, animations: { 
            self.pageTextLabel?.alpha = 0
        }) { (finished:Bool) in
            self.pageTextLabel?.text = self.pagesText[currentIndex]
            UIView.animateWithDuration(0.4, animations: { 
                self.pageTextLabel?.alpha = 1.0
                }, completion: { (finished:Bool) in
                    print("Finished transition")
            })
            
        }
        
        
    }
        
    
    // MARK: Datasource functions
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        //let previousIndex = abs((currentIndex - 1) % pages.count)
        let previousIndex = currentIndex-1
        
        if previousIndex < 0
        {
            return nil
        }
        else
        {
            return pages[previousIndex]
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        //let nextIndex = abs((currentIndex + 1) % pages.count)
        let nextIndex = currentIndex + 1
        if nextIndex == pages.count
        {
            return nil
        }
        else
        {
            return pages[nextIndex]
        }
    }
    
    @IBAction func onGetStartedPressed(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createUserVC: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("LoginUserViewController")
        
        self.navigationController?.setViewControllers([createUserVC], animated: true)
        
    }
    
    
}