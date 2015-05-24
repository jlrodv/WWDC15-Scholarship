//
//  AboutMeViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 22/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit
import MapKit

class AboutMeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var scrollContent: UIScrollView!
    
    let detailCellIdentifier : String = "infoCell"
    let picCellIdentifier : String = "picViewer"
    let picItemIdentifier : String = "collectionPic"
    let detailCellHeight : CGFloat = 64.0
    let picCellHeight : CGFloat = 143.0
    let detailArray : [String] = ["Name","Birth Date","From"]
    let detailInfoArray : [String] = ["Jose Luis Rodriguez Valdez", "1992/09/07", "Mexico City, Mexico"]
    var picDetail : Bool = false
    var detailIndex : Int!
    var selectedMenu : Int!
    var moved : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if(moved==false){
            moved = true
            super.viewDidAppear(animated)
            let yPosition : CGFloat = self.view.frame.size.height * (CGFloat(selectedMenu)  - 1.0)
            
            self.scrollContent.setContentOffset(CGPointMake(0,yPosition), animated: true)
            
            
            self.scrollContent.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 3)
        
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell!
        
        if(picDetail && indexPath.row + 1 == detailIndex){
            //here goes collection cell
            cell = tableView.dequeueReusableCellWithIdentifier(picCellIdentifier) as! UITableViewCell!
            
        }
        else{
            let rowItem :Int!
            if(picDetail && indexPath.row > detailIndex){
                rowItem = indexPath.row - 1
            }
            else{
                rowItem = indexPath.row
            }
            
            cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier) as! UITableViewCell!
            cell.textLabel?.text = detailArray[rowItem]
            cell.detailTextLabel?.text = detailInfoArray[rowItem]
        }
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
