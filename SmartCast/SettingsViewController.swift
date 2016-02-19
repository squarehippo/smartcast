//
//  SettingsViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

protocol SettingsViewDelegate {
    func setCurrentCityName(name: String)
    func getCurrentWeatherForecast(longlat: String)
    
}


import UIKit
import CoreLocation

class SettingsViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
/*-------------------------------------------------------------------------------------------------------------*/
    
    //var aCity = [City]()
    var delegate: SettingsViewDelegate!
    var cityText = ""
    var longlat = ""
    
    let geocoder = CLGeocoder()
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

/*-------------------------------------------------------------------------------------------------------------*/
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    

/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func seattleButton(sender: AnyObject) {
        pickedCity("Seattle, WA")
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func boulderButton(sender: AnyObject) {
       pickedCity("Sydney, Australia")
    }
    
/*-------------------------------------------------------------------------------------------------------------*/

    @IBAction func traverseCityButton(sender: AnyObject) {
        pickedCity("Traverse City, MI")
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func hillsboroughButton(sender: AnyObject) {
        pickedCity("Hillsborough, NC")
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func cupertinoButton(sender: AnyObject) {
        pickedCity("London, England")
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func pickedCity(name: String) {
        
        delegate.setCurrentCityName(name)
        
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
    
/*-------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------*/
    
}
