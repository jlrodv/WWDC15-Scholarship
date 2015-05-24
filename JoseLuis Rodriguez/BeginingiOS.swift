//
//  BeginingiOS.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 26/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit

class BeginingiOS: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let infoCellIdentifier : String = "infoCell"
    let infoAppCellIDentifier : String = "infoAppCell"
    let collectionScreen : String = "screen"
    let collectionButton : String = "button"
    let infoCellHeight :CGFloat = 134
    let infoAppHeight : CGFloat = 300
    var infoArray : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInfo()
    }
    
    func loadInfo(){
    
        let pathFile : String = NSBundle.mainBundle().pathForResource("begining", ofType: "json")!
        var jsonData : NSData = NSData(contentsOfFile: pathFile)!
        
        let beginingDictionary :NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        infoArray = beginingDictionary["content"] as! NSArray
        
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(infoArray.objectAtIndex(indexPath.row)["type"] as! String == "info"){
            
            return infoCellHeight
            
            
        }
        
        return infoAppHeight
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if(infoArray.objectAtIndex(indexPath.row)["type"] as! String == "info"){
        
            cell = tableView.dequeueReusableCellWithIdentifier(infoCellIdentifier) as! UITableViewCell
            
        }
        else{
        
            cell = tableView.dequeueReusableCellWithIdentifier(infoAppCellIDentifier) as! UITableViewCell
            
            var collectionView : UICollectionView! = cell.viewWithTag(4) as! UICollectionView
            
            
        }
        
        var img : UIImageView = cell.viewWithTag(1) as! UIImageView
        img.image = UIImage(named: (infoArray.objectAtIndex(indexPath.row)["icon"] as? String)!)
        img.layer.cornerRadius = 14;
        img.layer.masksToBounds = true
        
        var title : UILabel = cell.viewWithTag(2) as! UILabel
        title.text = infoArray.objectAtIndex(indexPath.row)["title"] as? String
        var info : UILabel = cell.viewWithTag(3) as! UILabel
        info.text = infoArray.objectAtIndex(indexPath.row)["info"] as? String
        
        
        return cell
    }
  
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if(indexPath.item == 3){
        
             var itemCell : UICollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(collectionButton, forIndexPath: indexPath) as? UICollectionViewCell)!
            var button : UIButton = itemCell.viewWithTag(11) as! UIButton
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1.0
            button.layer.borderColor = button.titleLabel?.textColor.CGColor
            
            return itemCell
        }
        
        var itemCell : UICollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(collectionScreen, forIndexPath: indexPath) as? UICollectionViewCell)!
        
        let tableIndex : NSIndexPath = self.tableView.indexPathForCell( collectionView.superview?.superview as! UITableViewCell)!
        
        var img : UIImageView = itemCell.viewWithTag(10) as! UIImageView
        
        let appName : String = (infoArray.objectAtIndex(tableIndex.row)["icon"] as? String)!
        
        let currentPic = indexPath.row + 1
        
        var imageName = "\(appName)\(currentPic)"
        
        println("" + imageName)
        
        img.image = UIImage(named:imageName)
        
        
        return itemCell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    
}
