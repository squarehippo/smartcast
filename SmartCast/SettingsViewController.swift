//
//  SettingsViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

protocol SettingsViewDelegate {
    func setCityName(name: String)
    func getCurrentWeatherForecast(longlat: String)
    
}


import UIKit
import CoreLocation

class SettingsViewController: UIViewController {
    
    
    var aCity = [City]()
    var delegate: SettingsViewDelegate!
    var cityText = ""
    var longlat = ""
    
    let geocoder = CLGeocoder()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func boulderButton(sender: AnyObject) {
       pickedCity("Sydney, Australia")
    }

    @IBAction func traverseCityButton(sender: AnyObject) {
        pickedCity("Traverse City, MI")
    }
    
    @IBAction func hillsboroughButton(sender: AnyObject) {
        pickedCity("Hillsborough, NC")
    }
    
    @IBAction func cupertinoButton(sender: AnyObject) {
        pickedCity("London, England")
    }
    
    func pickedCity(name: String) {
        
        delegate.setCityName(name)
        
        geocoder.geocodeAddressString(name, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.longlat = "\(coordinates.latitude),\(coordinates.longitude)"
                self.delegate.getCurrentWeatherForecast(self.longlat)
                //print(coordinates)
            }
        })
        
         self.dismissViewControllerAnimated(true, completion: nil)

    }
    
//    func parseCityCSV() {
//        let path = NSBundle.mainBundle().pathForResource("cities", ofType: "csv")!
//        
//        do {
//            let csv = try CSV(contentsOfURL: path)
//            let rows = csv.rows
//            
//            for row in rows {
//                let name = row["city"]
//                let state = row["state"]
//                let lat = row["lat"]
//                let lng = row["lng"]
//                let city = City(name: name!, state: state!, latitude: lat!, longitude: lng!)
//                aCity.append(city)
//            }
//            
//        } catch let err as NSError {
//            print(err.debugDescription)
//        }
//    }
    
}
