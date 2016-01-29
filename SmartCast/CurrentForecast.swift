//
//  CurrentForecast.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class CurrentForecast {
    
    private var _currentCity: String!
    private var _currentTemp: String!
    private var _weatherSummary: String!
    private let _weatherURL: String!
    
    var currentCity: String {
        return _currentCity
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
    
    
    func downloadCurrentForecast(completed: DownloadComplete) {
        
        let urlString = "https://api.forecast.io/forecast/c5dc2f6d05b3e421341cd8d53718db2e/36.073522,-79.116669"
        let session = NSURLSession.sharedSession()
        if let url = NSURL(string: urlString) {
            
            let task = session.dataTaskWithURL(url) {( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                if let responseData = data {
                    
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                        
                        guard let dict = json as? NSDictionary,
                            let curForecast = dict["currently"] as? Dictionary<String, AnyObject>,
                            let curTemp = curForecast["temperature"] as? Double else {
                            return
                        }
                        self._currentTemp = String(format: "%.0f°", curTemp)
                        completed()
                        
                    } catch {
                        print("whoops")
                    }
                }
            }
            task.resume()
        }
        
    }
}