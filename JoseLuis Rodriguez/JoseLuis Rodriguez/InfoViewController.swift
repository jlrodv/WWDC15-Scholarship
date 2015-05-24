//
//  InfoViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 25/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var educationImage: UIImageView!
    @IBOutlet weak var workImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.adjustUIComponents()
        
    }
    
    func adjustUIComponents(){

        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImage.layer.borderWidth = 1.5
        self.profileImage.layer.masksToBounds = true
        
        self.educationImage.layer.cornerRadius = 8.0
        self.educationImage.layer.masksToBounds = true
        self.workImage.layer.cornerRadius = 8.0
        self.workImage.layer.masksToBounds = true
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("%@",  self.parentViewController!)
        
        if(indexPath.row == 1){
            self.addAbout()
        }
    }
    
    func addAbout(){
    
        let detailOffset : CGFloat = 30.0 as CGFloat
        
        
        
        let view : UIView = UIView(frame: CGRectMake(detailOffset, detailOffset, self.view.frame.size.width - detailOffset - detailOffset, self.parentViewController?.view.frame.size.height as CGFloat! - 66 - detailOffset - detailOffset))
        view.backgroundColor = UIColor(red: 247.0 / 255.0 , green: 249.0 / 255.0, blue: 249/255.0, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.tag = 80;
        view.layer.masksToBounds = true
        self.view.addSubview(view)
        
        let aboutText : UITextView = UITextView(frame: CGRectMake(0, 0, view.frame.size.width - 20, view.frame.size.height-30))
        aboutText.editable = false
        aboutText.backgroundColor = UIColor.clearColor()
        aboutText.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0)
        aboutText.textColor = UIColor.blackColor()
        aboutText.font = UIFont(name: "Avenir-Light", size: 17)
        aboutText.text = "Hi I'm Jose Luis Rodriguez Valdez, a 22 year old developer born in Mexico city in 1992. I got into the computers world at six years old when my parents bought me my first computer. Since then I have been impressed with the power and capabilities of what a computer can do. So Im always searching the way a computer can help us to improve our lifes. Thats why I'm studying Computer Engineering focusing in Software Engineering. Thats how I discovered my favourite hobbie that is programming. Other things that I enjoy in life is going out with my girlfriend, go to the movies, play sports, eat delicious food, and also teach others what I've been learning these years. "
        aboutText.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2)
        
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissView"))
        view.addGestureRecognizer(gesture)
        view.addSubview(aboutText)
        
    }
    
    func dismissView(){
        self.view.viewWithTag(80)?.removeFromSuperview()
    
    }
   
    
}