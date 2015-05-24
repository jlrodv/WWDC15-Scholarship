//
//  IOSDeveloperViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 26/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit

class IOSDeveloperViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    let menuCellHeight : Int = 50
    let menuStrings : [String] = ["Begining in iOS Development","Apps and Hackatons"]
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.layoutIfNeeded()
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row==0){
            
            let menuHeight : CGFloat = CGFloat (self.menuCellHeight * self.menuStrings.count)
            
            return self.tableView.frame.size.height - menuHeight
        
        }
        
        return CGFloat( self.menuCellHeight)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuStrings.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
        
            return tableView.dequeueReusableCellWithIdentifier("headerCell") as! UITableViewCell
        
        }
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("menuCell") as! UITableViewCell
        
        cell.textLabel?.text = menuStrings[indexPath.row - 1]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.parentViewController)
        
        if(indexPath.row>0){
        
            if(indexPath.row==1){
            
                self.parentViewController?.performSegueWithIdentifier("begining", sender: nil)
            }
            else if(indexPath.row == 2){
                self.parentViewController?.performSegueWithIdentifier("showApps", sender: nil)

            }
        
        }
        
    }
    
}
