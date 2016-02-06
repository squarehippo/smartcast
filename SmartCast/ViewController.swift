//
//  ViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/27/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, SettingsViewDelegate {
    
    var forecast = CurrentForecast()
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherSummary: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var day1Name: UILabel!
    @IBOutlet weak var day2Name: UILabel!
    @IBOutlet weak var day3Name: UILabel!
    @IBOutlet weak var day4Name: UILabel!
    @IBOutlet weak var day5Name: UILabel!
    @IBOutlet weak var day1Max: UILabel!
    @IBOutlet weak var day1Min: UILabel!
    @IBOutlet weak var day2Max: UILabel!
    @IBOutlet weak var day2Min: UILabel!
    @IBOutlet weak var day3Max: UILabel!
    @IBOutlet weak var day3Min: UILabel!
    @IBOutlet weak var day4Max: UILabel!
    @IBOutlet weak var day4Min: UILabel!
    @IBOutlet weak var day5Max: UILabel!
    @IBOutlet weak var day5Min: UILabel!
    @IBOutlet weak var day1Icon: UIImageView!
    @IBOutlet weak var day2Icon: UIImageView!
    @IBOutlet weak var day3Icon: UIImageView!
    @IBOutlet weak var day4Icon: UIImageView!
    @IBOutlet weak var day5Icon: UIImageView!
    @IBOutlet weak var rainPercent: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet var backgroundColor: UIView!
    @IBOutlet weak var dateToday: UILabel!
    @IBOutlet weak var rainOrSnow: UILabel!

    
    var longlat = ""
        
    
    

    
    @IBAction func GoToSettings(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets up app delegate which is used to refresh data when app returns from background
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        appDelegate.myViewController = self
        
        getCurrentWeatherForecast(longlat)
        setCityName("Hillsborough")
        
    }
    
    func getCurrentWeatherForecast(longlat: String) {
        print("longlat = \(longlat)")
        
        var currentLocation: String
        
        if longlat == "" {
            currentLocation = "36.073522,-79.116669"
        } else {
            currentLocation = longlat
        }
        
        let thisDay = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        dateToday.text = formatter.stringFromDate(thisDay)
        
        
        //Keeps the setting button from gettting squished
        settings.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        settings.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        settings.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        
        
        forecast.downloadCurrentForecast(currentLocation) { () -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.currentTemperature.text = self.forecast.currentTemp
                self.rainPercent.text = self.forecast.currentPrecipProbability
                
                /*----------------------------------------------------*/
                //Testing current icon - comment out one line or the other

                self.currentIcon.image = UIImage(named: self.forecast.currentIcon)
                //self.currentIcon.image = UIImage(named: "rain") //partly-cloudy-day
                /*----------------------------------------------------*/
                
                //self.city.text = self.forecast.currentCity
                self.weatherSummary.text = self.forecast.weatherSummary
                self.day1Name.text = self.forecast.day1Name
                self.day2Name.text = self.forecast.day2Name
                self.day3Name.text = self.forecast.day3Name
                self.day4Name.text = self.forecast.day4Name
                self.day5Name.text = self.forecast.day5Name
                self.day1Max.text = self.forecast.day1MaxTemp
                self.day1Min.text = self.forecast.day1MinTemp
                self.day2Max.text = self.forecast.day2MaxTemp
                self.day2Min.text = self.forecast.day2MinTemp
                self.day3Max.text = self.forecast.day3MaxTemp
                self.day3Min.text = self.forecast.day3MinTemp
                self.day4Max.text = self.forecast.day4MaxTemp
                self.day4Min.text = self.forecast.day4MinTemp
                self.day5Max.text = self.forecast.day5MaxTemp
                self.day5Min.text = self.forecast.day5MinTemp
                self.day1Icon.image = UIImage(named: self.forecast.day1Icon)
                self.day2Icon.image = UIImage(named: self.forecast.day2Icon)
                self.day3Icon.image = UIImage(named: self.forecast.day3Icon)
                self.day4Icon.image = UIImage(named: self.forecast.day4Icon)
                self.day5Icon.image = UIImage(named: self.forecast.day5Icon)
                self.wind.text = "\(self.forecast.windBearing) \(self.forecast.windSpeed)"
                self.sunrise.text = self.forecast.currentSunriseTime
                self.sunset.text = self.forecast.currentSunsetTime
                
                if Int(self.forecast.currentTemp) <= 32 {
                    self.rainOrSnow.text = "snow"
                } else {
                    self.rainOrSnow.text = "rain"
                }
                
                self.setBackgroundColor()
            }
        }

        
    }
    
    func setBackgroundColor() {
        
        let icon = self.forecast.currentIcon
        if self.isItDaytime(self.forecast.currentTimeZoneOffset) == false {
            self.backgroundColor.backgroundColor = UIColor.darkGrayColor()
        } else if icon == "rain" || icon == "cloudy" || icon == "fog" || icon == "snow" || icon == "sleet" {
            self.backgroundColor.backgroundColor = UIColor.grayColor()
        } else {
            self.backgroundColor.backgroundColor = UIColor(hexString: "#06A3FD")
        }
    }
    
    func setCityName(name: String) {
        city.text = name.uppercaseString
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToSettings") {
            let destination  = segue.destinationViewController as! SettingsViewController
            destination.delegate = self
        }
    }
    
    func isItDaytime(offset: Int) -> Bool {
        //print("viewCOntroller offset = \(offset)")
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let nowAsString = dateFormatter.stringFromDate(now)
        let curOffsetinSeconds: NSTimeInterval = Double(offset * 60) * 60
        //print(curOffsetinSeconds)
        
        let curSunrise = dateFormatter.dateFromString(sunrise.text!)?.dateByAddingTimeInterval(curOffsetinSeconds)
        let curSunset = dateFormatter.dateFromString(sunset.text!)?.dateByAddingTimeInterval(curOffsetinSeconds)
        let rightNow = dateFormatter.dateFromString(nowAsString)?.dateByAddingTimeInterval(curOffsetinSeconds)
        
        //print(rightNow)
 
        if curSunrise!.compare(rightNow!) == NSComparisonResult.OrderedAscending &&
            curSunset!.compare(rightNow!) == NSComparisonResult.OrderedDescending {
            return true
        } else {
            return false
        }
    }
        
  

}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night

