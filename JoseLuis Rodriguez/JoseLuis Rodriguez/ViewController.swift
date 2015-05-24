//
//  ViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 21/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let PROFILE_IMAGE_SIZE : CGFloat = 150.0;
    var profileImage: UIImageView!
    var welcomeLabel: UILabel!
    var welcomeInfoLabel: UILabel!
    var tableMenu: UITableView!
    let menuStrings:[String] = ["Jose Luis Rodriguez", "About me", "Education", "iOS Dev"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.createUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(self.tableMenu == nil){
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                
                    self.profileImage.alpha = 1.0
                    self.welcomeLabel.alpha = 1.0
                    self.welcomeLabel.center = CGPointMake(self.welcomeLabel.center.x, self.profileImage.frame.origin.y/2)
                
                
                }, completion:{(finished: Bool) in
                    if(finished){
                    
                        UIView.animateWithDuration(0.3, animations: {
                        
                            self.welcomeInfoLabel.alpha = 1.0
                        })
                    }
                
                })
        }
        
    }
    
    func createUI(){
        
        self.profileImage = UIImageView(frame: CGRectMake(0.0, 0.0, PROFILE_IMAGE_SIZE, PROFILE_IMAGE_SIZE))
        self.profileImage.image = UIImage(named: "Profile")
        self.profileImage.center = self.view.center;
        self.profileImage.layer.cornerRadius = profileImage.frame.size.height/2;
        self.profileImage.layer.borderWidth = 2;
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor;
        self.profileImage.layer.masksToBounds = true;
        self.profileImage.alpha = 0.0;
        self.profileImage.userInteractionEnabled = true
        self.view.addSubview(self.profileImage)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("profilePressed:"))
        self.profileImage.addGestureRecognizer(tapGesture)
        
        
        self.welcomeLabel = UILabel(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width - 20, 80))
        self.welcomeLabel.font = UIFont(name: "Avenir Medium", size: 23)
        self.welcomeLabel.textColor = UIColor.whiteColor()
        self.welcomeLabel.text = "Welcome to Jose Luis WWDC 15 Scholarship App"
        self.welcomeLabel.numberOfLines = 3;
        self.welcomeLabel.textAlignment = NSTextAlignment.Center
        self.welcomeLabel.sizeToFit()
        self.welcomeLabel.alpha = 0.0;
        self.welcomeLabel.center = CGPointMake(self.view.center.x, -self.welcomeLabel.frame.size.height)
        self.view.addSubview(self.welcomeLabel)
        
        self.welcomeInfoLabel = UILabel (frame: CGRectMake(0.0, 0.0, 200.0, 50.0))
        self.welcomeInfoLabel.font = UIFont(name: "Avenir-LightOblique", size: 17)
        self.welcomeInfoLabel.textColor = UIColor.whiteColor()
        self.welcomeInfoLabel.text = "Tap Jose Luis face to start"
        self.welcomeInfoLabel.textAlignment = NSTextAlignment.Center
        self.welcomeInfoLabel.sizeToFit()
        self.welcomeInfoLabel.alpha = 0.0;
        self.welcomeInfoLabel.center = CGPointMake(self.view.center.x, self.profileImage.frame.origin.y+self.profileImage.frame.size.height + 8 + (self.welcomeInfoLabel.frame.size.height/2))
        self.view.addSubview(self.welcomeInfoLabel)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func profilePressed(recognizer: UITapGestureRecognizer){
    
        NSLog("Pressed" )
        
        if(self.tableMenu == nil){
            self.addTableToView()
            self.animateTransition()
        }
    }
    
    func addTableToView(){
    
        self.tableMenu = UITableView(frame: CGRectMake(self.view.frame.origin.x + 10, self.view.frame.size.height, self.view.frame.size.width - 20, self.view.frame.size.height - PROFILE_IMAGE_SIZE - 8 - 20), style: UITableViewStyle.Plain)
        self.tableMenu.delegate = self
        self.tableMenu.dataSource = self
        self.tableMenu.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.tableMenu.backgroundView = nil
        self.tableMenu.layer.cornerRadius = 8;
        self.tableMenu.layer.masksToBounds = true;
        self.view.addSubview(self.tableMenu)
    }
    
    func animateTransition(){
        
        
        UIView.animateWithDuration(0.7, animations: {
        
            self.welcomeInfoLabel.alpha = 0.0
            self.welcomeLabel.frame = CGRectMake(self.welcomeLabel.frame.origin.x, self.welcomeLabel.frame.origin.y, 0, self.welcomeLabel.frame.size.height)
            self.profileImage.center = CGPointMake(self.profileImage.center.x, 20 + 8 + self.profileImage.frame.size.height/2)
            self.tableMenu.center = CGPointMake(self.view.center.x, self.PROFILE_IMAGE_SIZE + 16 + 20 + self.tableMenu.frame.size.height/2)
            
        
        })
        
        
    }
    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return menuStrings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseCell") as! UITableViewCell!
        if (cell == nil) {
            cell = UITableViewCell(style:.Default, reuseIdentifier: "reuseCell")
            cell.textLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
            cell.backgroundView = nil
            cell.backgroundColor = UIColor.clearColor()
        }
        
        if(indexPath.row == 0){
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.textAlignment = NSTextAlignment.Center
        }
        else{
            cell.selectionStyle = UITableViewCellSelectionStyle.Default;
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.textAlignment = NSTextAlignment.Left

        }
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = menuStrings[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row==0){
            return
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let segueIdentifier :String! = "about"
        
        self.performSegueWithIdentifier(segueIdentifier, sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationController : AboutMeViewController = segue.destinationViewController as! AboutMeViewController
        let index : NSIndexPath = sender as! NSIndexPath
        
        destinationController.selectedMenu = index.row
        
    }

}

