//
//  AppsViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 26/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit
import StoreKit

class AppsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,SKStoreProductViewControllerDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var apps : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInfo()
        
        
    }
    
    func loadInfo(){
        
        let pathFile : String = NSBundle.mainBundle().pathForResource("apps", ofType: "json")!
        var jsonData : NSData = NSData(contentsOfFile: pathFile)!
        
        let beginingDictionary :NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        apps = beginingDictionary["apps"] as! NSArray

    
    
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("app", forIndexPath: indexPath) as! UICollectionViewCell
        
        var label : UILabel = cell.viewWithTag(2) as! UILabel
        label.text = apps.objectAtIndex(indexPath.row)["title"] as? String
        var icon : UIImageView = cell.viewWithTag(1) as! UIImageView
        icon.layer.cornerRadius = 12
        icon.layer.masksToBounds = true
        icon.image = UIImage(named: (apps.objectAtIndex(indexPath.row)["icon"] as? String)!)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(apps.objectAtIndex(indexPath.row)["place"] as! String == "appStore"){
        
            var store : SKStoreProductViewController = SKStoreProductViewController() as SKStoreProductViewController
            store.delegate = self
            store.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier : apps.objectAtIndex(indexPath.row)["appStoreLink"] as! String ], completionBlock: nil)
            
            self.presentViewController(store, animated: true, completion: nil)
            
            print("app store dialog")
        }
        else{
            print("safari")
            var alert:UIAlertController  = UIAlertController(title: "Open In", message: "Do you want to open this in Safari?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Cancel",
                style: UIAlertActionStyle.Cancel,
                handler: {(alert: UIAlertAction!)in
                    
                    println("cancel")}))

            
            alert.addAction(UIAlertAction(title: "Open",
                style: UIAlertActionStyle.Default,
                handler: {(alert: UIAlertAction!)in
                         UIApplication.sharedApplication().openURL(NSURL(string: self.apps.objectAtIndex(indexPath.row)["appStoreLink"] as! String )!)
                    println("open")}))
            
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
    }
    
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
