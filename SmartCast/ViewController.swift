//
//  ViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/27/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var forecast = CurrentForecast()
    
    @IBOutlet weak var city: UILabel?
    @IBOutlet weak var weatherSummary: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var settings: UIButton!
    

    
    @IBAction func GoToSettings(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        settings.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        settings.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        
        
        forecast.downloadCurrentForecast { () -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.currentTemperature.text = self.forecast.currentTemp
                self.weatherSummary.text = self.forecast.weatherSummary
                self.city?.text = self.forecast.currentCity
            }
        }
    }
    
    
    
  

}

