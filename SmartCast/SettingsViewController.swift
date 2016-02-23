//
//  SettingsViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//



import UIKit
import CoreLocation

class SettingsViewController: UITableViewController {
    
    var cities = ["Hillsborough, NC", "Traverse City, MI", "Moscow, russia", "mexico", "Aspen, CO", "Seattle, WA", "London, England", "Buffalo, NY"]

/*-------------------------------------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
/*-------------------------------------------------------------------------------------------------------------*/

    @IBAction func addCity(sender: AnyObject) {
        
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseId", forIndexPath: indexPath)
        
        cell.textLabel?.text = formatCityName(cities[indexPath.row])
        
        return cell
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func formatCityName(name: String) -> String {
        var myCityArray = name.componentsSeparatedByString(",")
        return myCityArray[0].capitalizedString
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------*/

}































//protocol SettingsViewDelegate {
//    func setCurrentCityName(name: String)
//    func getCurrentWeatherForecast(longlat: String)
//    
//}
//
//
//import UIKit
//import CoreLocation
//
//class SettingsViewController: UITableViewController, UISearchBarDelegate {
//
//    @IBOutlet weak var searchBar: UISearchBar!
///*-------------------------------------------------------------------------------------------------------------*/
//    
//    var aCity = [City]()
//    var delegate: SettingsViewDelegate!
//    var cityText = ""
//    var longlat = ""
//    
//    let geocoder = CLGeocoder()
//    
///*-------------------------------------------------------------------------------------------------------------*/
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchBar.delegate = self
//    }
//
///*-------------------------------------------------------------------------------------------------------------*/
//    
//    func getForecastForCityName(name: String) {
//        
//        delegate.setCurrentCityName(name)
//        
//        geocoder.geocodeAddressString(name, completionHandler: {(placemarks, error) -> Void in
//            if((error) != nil){
//                print("Error", error)
//            }
//            if let placemark = placemarks?.first {
//                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
//                self.longlat = "\(coordinates.latitude),\(coordinates.longitude)"
//                self.delegate.getCurrentWeatherForecast(self.longlat)
//                //print(coordinates)
//            }
//        })
//        
//         self.dismissViewControllerAnimated(true, completion: nil)
//
//    }
//    
///*-------------------------------------------------------------------------------------------------------------*/
///*-------------------------------------------------------------------------------------------------------------*/
//    
//}
