//
//  SettingsViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

protocol SettingsViewDelegate {
    func setCityName(name: String)
}

import UIKit

class SettingsViewController: UIViewController {
    
    
    var aCity = [City]()
    var delegate: SettingsViewDelegate!
    var cityText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseCityCSV()
        
        delegate.setCityName(aCity[5].name)
        
        print(aCity[5].name)
    }
    
    
    @IBAction func citySelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    func parseCityCSV() {
        let path = NSBundle.mainBundle().pathForResource("cities", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let name = row["city"]
                let state = row["state"]
                let lat = row["lat"]
                let lng = row["lng"]
                let city = City(name: name!, state: state!, latitude: lat!, longitude: lng!)
                aCity.append(city)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    
}
