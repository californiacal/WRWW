//
//  ImageCaptureClothingViewController.swift
//  WRWW
//
//  Created by John Swensen on 7/1/16.
//  Copyright © 2016 WRWW. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import CameraManager




class ImageCaptureClothingViewController : UIViewController {
    
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    
    let cameraManager = CameraManager()
    
    let grabCutManager:GrabCutManager? = GrabCutManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the login button
        takePhotoButton.layer.cornerRadius = takePhotoButton.frame.height/2
        takePhotoButton.layer.borderWidth = 0
        takePhotoButton.layer.borderColor = UIColor.clearColor().CGColor
        
        
        // Create the full color button for the toolbar
        let image1:UIImage? = self.topToolbar.items![(self.topToolbar.items?.count)!-2].image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem1:UIBarButtonItem? = UIBarButtonItem(image: image1, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ImageCaptureClothingViewController.onHelpBarItem))
        
        let image2:UIImage? = self.topToolbar.items![(self.topToolbar.items?.count)!-1].image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let barItem2:UIBarButtonItem? = UIBarButtonItem(image: image2, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ImageCaptureClothingViewController.onBackBarItem))
        
        // Replace the last item with the full-color item
        var pp = self.topToolbar.items
        pp![(pp?.count)!-2] = barItem1!
        pp![(pp?.count)!-1] = barItem2!
        self.topToolbar.setItems(pp, animated: false)
        
        
        // Set up the camera capture
        self.cameraManager.addPreviewLayerToView(self.cameraView)
        self.cameraManager.cameraDevice = .Back
        cameraManager.cameraOutputMode = .StillImage
        cameraManager.cameraOutputQuality = .High
        cameraManager.flashMode = .Auto
        cameraManager.writeFilesToPhoneLibrary = false
        
        
        self.view.bringSubviewToFront(self.takePhotoButton)
        
    }
    
    func maskImage(image:UIImage, mask:(UIImage))->UIImage{
        
        let imageReference = image.CGImage
        let maskReference = mask.CGImage
        
        let imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference),
                                          CGImageGetHeight(maskReference),
                                          CGImageGetBitsPerComponent(maskReference),
                                          CGImageGetBitsPerPixel(maskReference),
                                          CGImageGetBytesPerRow(maskReference),
                                          CGImageGetDataProvider(maskReference), nil, true)
        
        let maskedReference = CGImageCreateWithMask(imageReference, imageMask)
        
        let maskedImage = UIImage(CGImage:maskedReference!)
        
        return maskedImage
    }
    
    @IBAction func onTakePhotoPressed(sender: AnyObject) {
        
        self.cameraManager.capturePictureWithCompletition({ (image, error) -> Void in
            //self.myImage = image
            let testImage = UIImage(named: "ShirtOnFloor")
            let segmented:UIImage! = self.grabCutManager?.doGrabCut(testImage, foregroundBound: CGRect(x: 0, y:0, width: 312, height: 493), iterationCount: 5)
            
            do {
                try UIImagePNGRepresentation(segmented)?.writeToFile("/Users/jpswensen/Desktop/image.png", options: NSDataWritingOptions.AtomicWrite)
            }
            catch {
                print (error)
            }
            // FIXME: Move to the next view with the selected image
        })
        
        let testImage = UIImage(named: "JohnShirt")
        let mask:UIImage! = self.grabCutManager?.doGrabCut(testImage, foregroundBound: CGRect(x: 5, y:77, width: 806, height: 667), iterationCount: 20)
        let segmented:UIImage! = self.maskImage(testImage!, mask: mask)
        
        do {
            UIGraphicsBeginImageContext(mask.size);
            mask.drawAtPoint(CGPointZero)
            let newMask = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            try UIImagePNGRepresentation(newMask)?.writeToFile("/Users/jpswensen/Desktop/mask.png", options: NSDataWritingOptions.AtomicWrite)
            
            
            UIGraphicsBeginImageContext(segmented.size);
            segmented.drawAtPoint(CGPointZero)
            let newSegmented = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            try UIImagePNGRepresentation(newSegmented)?.writeToFile("/Users/jpswensen/Desktop/segmented.png", options: NSDataWritingOptions.AtomicWrite)
        }
        catch {
            print (error)
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
        
        
        alertView.showInfo("Help", subTitle: "You are now photographing your own clothing to add to your closet. Tips: Lay your piece out flat on a white surface. Make sure you are in a well-lit location. Lean over your piece and photograph your item from directly above. Click \"Take Photo\". You may be asked to give this app permission to use your camera. Click the back arrow in the top right to go back and change the clothing category.", closeButtonTitle: "Got It!", duration: 0, colorStyle: 0xFFFFFF, colorTextButton: 0xE4327B, circleIconImage: alertViewIcon)
    }
    
    func onBackBarItem(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func cameraShotFinished(image: UIImage) {
        
    }
    
}
