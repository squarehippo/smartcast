//
//  CurrentForecast.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit
import MapKit

class CurrentForecast {
    
    private var _currentCity: String?
    private var _currentTemp: String!
    private var _weatherSummary: String!
    private let _weatherURL: String!
    
    var currentCity: String {
        if _currentCity != nil {
            return _currentCity!
        } else {
            return "--"
        }
        
    }
    
    var currentTemp: String {
        return _currentTemp
    }
    
    var weatherSummary: String {
        return _weatherSummary
    }
    
    init() {
        _weatherURL = "\(BASE_URL)\(KEY)\(HILLSBOROUGH)"
    }
    
    var longitude = 36.073522
    var latitude = -79.116669
    
    
    func downloadCurrentForecast(completed: DownloadComplete) {
        
        let longlat = "\(longitude),\(latitude)"
        
        let urlString = "https://api.forecast.io/forecast/c5dc2f6d05b3e421341cd8d53718db2e/\(longlat)"
        let session = NSURLSession.sharedSession()
        if let url = NSURL(string: urlString) {
            
            let task = session.dataTaskWithURL(url) {( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                self.setUsersClosestCity(self.longitude, curLongitude: self.latitude)
                
                if let responseData = data {
                    
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                        
                        guard let dict = json as? NSDictionary,
                            let curForecast = dict["currently"] as? Dictionary<String, AnyObject>,
                            let curTemp = curForecast["temperature"] as? Double else {
                            return
                        }
                        //Today's temperature
                        self._currentTemp = String(format: "%.0f°", curTemp)
                        
                        guard let curSummary = curForecast["summary"] as? String else {
                            return
                        }
                        //Today's weather summary
                        self._weatherSummary = curSummary
                        
                        
                        guard let curDetails = dict["daily"] as? Dictionary<String, AnyObject>,
                            let dailyDetails = curDetails["data"] as? [Dictionary<String, AnyObject>],
                            let maxTemp = dailyDetails[0]["temperatureMax"] as? Double else {
                            return
                        }
                        //Today's max temp
                        print(maxTemp)
                        
                        guard let dailySummary = curDetails["summary"] as? String else {
                            return
                        }
                        self._weatherSummary = dailySummary

                        
                        
                        
                        
                        
                        
                        completed()
                        
                        
                        
                    } catch {
                        print("whoops")
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func setUsersClosestCity(curLatitude: Double, curLongitude: Double)
    {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: curLatitude, longitude: curLongitude)
        geoCoder.reverseGeocodeLocation(location)
            {
                (placemarks, error) -> Void in
                
                let placeArray = placemarks as [CLPlacemark]!
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                // City
                if let city = placeMark.addressDictionary?["City"] as? NSString
                {
                    self._currentCity = String(city.uppercaseString)
                }
                
        }
    }

}