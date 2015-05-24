//
//  EducationViewController.swift
//  JoseLuis Rodriguez
//
//  Created by Jose Luis Rodriguez on 26/04/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

import UIKit
import MapKit

class EducationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var showButton: UIButton!
    
    let noSelectionHeight : CGFloat = 70
    let selectedHeight : CGFloat = 120
    var selectedSchool : AnyObject!
    var schools : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadDataInView()
        
    }
    
    func loadDataInView(){
    
        let pathFile : String = NSBundle.mainBundle().pathForResource("schools", ofType: "json")!
        var jsonData : NSData = NSData(contentsOfFile: pathFile)!
        
        let schoolsDictionary :NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        schools = schoolsDictionary["schools"] as! NSArray
    
        for school in schools{
            var dropPin = MKPointAnnotation()
            dropPin.coordinate = CLLocationCoordinate2DMake(school["latitude"] as! Double, school["longitude"] as! Double)
            dropPin.title = school["name"] as! String
            mapView.addAnnotation(dropPin)
        }
        
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.allAnnotationsVisible()
    }
    
    
    func allAnnotationsVisible(){
        

    
        mapView.showAnnotations(mapView.annotations, animated: true)
        
//when map view is covered partially by navigation bar
//        let newRegion : MKCoordinateRegion = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpanMake(self.mapView.region.span.latitudeDelta - 1.0, self.mapView.region.span.longitudeDelta - 1.0))
//        
//        self.mapView.region = newRegion

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return selectedHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell!
        
        cell = tableView.dequeueReusableCellWithIdentifier("school") as! UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        var schoolImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        schoolImage.layer.cornerRadius = 10
        schoolImage.layer.masksToBounds = true
        schoolImage.image = UIImage(named: (schools.objectAtIndex(indexPath.row)["image"] as? String)!)
        
        var name : UILabel = cell.viewWithTag(2) as! UILabel
        name.text = schools.objectAtIndex(indexPath.row)["name"] as? String
        
        
        var years : UILabel = cell.viewWithTag(3) as! UILabel
        years.text = schools.objectAtIndex(indexPath.row)["years"] as? String
        
        var level : UILabel = cell.viewWithTag(4) as! UILabel
        level.text = schools.objectAtIndex(indexPath.row)["level"] as? String

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        showButton.hidden = false
        
        let selectedAnnotation : String = schools.objectAtIndex(indexPath.row)["name"] as! String
        
        for annotation in self.mapView.annotations{
            
            let item :MKAnnotation = annotation as! MKAnnotation
            
            if( item.title == selectedAnnotation){
                self.mapView.showAnnotations([annotation], animated: true)
            }
            
        }
        
    }
    
    @IBAction func showPressed(sender: UIButton) {
        
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: true)
        
        sender.hidden = true
        
        self.allAnnotationsVisible()
    }
    
}
