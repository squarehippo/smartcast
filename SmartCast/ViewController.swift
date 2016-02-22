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
    
    @IBOutlet weak var city: UIButton!
    @IBOutlet weak var weatherSummary: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var tempSymbol: UILabel!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var day1Name: UILabel!
    @IBOutlet weak var day2Name: UILabel!
    @IBOutlet weak var day3Name: UILabel!
    @IBOutlet weak var day4Name: UILabel!
    @IBOutlet weak var day5Name: UILabel!
    @IBOutlet weak var day0Max: UILabel!
    @IBOutlet weak var day0Min: UILabel!
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
    @IBOutlet weak var particleView: UIView!
    @IBOutlet weak var hills: UIImageView!
    @IBOutlet weak var pageCount: UIPageControl!
    @IBOutlet weak var backgroundImage: UIImageView!
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    var forecast = CurrentForecast()

    var longlat = ""
    var timeZoneOffset: Double = 0.0
    var iconVisible = true
        
    var snow = SnowParticle()
    var rain = RainParticle()
    var stars = StarParticle()
    
    var weatherBackground = UIColor(hexString: "#06A3FD")
    var isAnimating = false
    
    var cityName = ""
    var index = 0
    var indexCount = 0
    
    let geocoder = CLGeocoder()
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func GoToSettings(sender: AnyObject) {
        
        isAnimating = false
        
        currentTemperature.fadeIn()
        tempSymbol.fadeIn()
        weatherSummary.fadeIn()
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    @IBAction func taps(sender: UITapGestureRecognizer) {
        
        if !isAnimating {
            currentTemperature.fadeOut()
            currentIcon.dropIcon(view)
            tempSymbol.fadeOut()
            weatherSummary.fadeOut()
            if whichBackgroundShouldIUse() == "night"  {
                backgroundImage.image = UIImage(named: "moonray")
            } else {
                backgroundImage.image = UIImage(named: "sunray")
            }
            //backgroundColor.fadeBackgroundOut()
            backgroundImage.fadeToImage()
            isAnimating = true
            
        } else {
            currentTemperature.fadeIn()
            currentIcon.raiseIcon(view)
            tempSymbol.fadeIn()
            weatherSummary.fadeIn()
            //backgroundColor.fadeBackgroundIn(weatherBackground)
            backgroundImage.fadeOutImage()
            isAnimating = false
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("5. view controller - getting variables from page view controller")

        forecastForCityName(cityName)
        setCurrentCityName(cityName)

        pageCount.numberOfPages = indexCount
        pageCount.currentPage = index
  
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
//Change city name to coordinates and call API
    
    func forecastForCityName(name: String) {

        geocoder.geocodeAddressString(name, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.longlat = "\(coordinates.latitude),\(coordinates.longitude)"
                self.getCurrentWeatherForecast(self.longlat)
                
            }
        })
    }

/*-------------------------------------------------------------------------------------------------------------*/
    
    func getCurrentWeatherForecast(longlat: String) {
        
        let currentLocation = longlat
        
        
        
//        let thisTimeZoneOffset = Double(NSTimeZone.systemTimeZone().secondsFromGMT)
//        
//        let totalTimeZoneOffset = thisTimeZoneOffset - ((timeZoneOffset * 60) * 60)
//        
//        let now = NSDate.init(timeInterval: -totalTimeZoneOffset, sinceDate: NSDate())
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "h:mm a"
//        let nowAsString = dateFormatter.stringFromDate(now)
//        let rightNow = dateFormatter.dateFromString(nowAsString)
//        dateToday.text = "\(rightNow)"
        
        
        
        
        
        let thisDay = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        //dateFormatter.dateStyle = .LongStyle
        //dateFormatter.timeStyle = .LongStyle
        dateToday.text = dateFormatter.stringFromDate(thisDay)
        
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
                
                self.weatherSummary.text = self.forecast.weatherSummary
                self.day1Name.text = self.forecast.day1Name
                self.day2Name.text = self.forecast.day2Name
                self.day3Name.text = self.forecast.day3Name
                self.day4Name.text = self.forecast.day4Name
                self.day5Name.text = self.forecast.day5Name
                self.day0Max.text = "H \(self.forecast.day0MaxTemp)"
                self.day0Min.text = "L \(self.forecast.day0MinTemp)"
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
                self.timeZoneOffset = self.forecast.currentTimeZoneOffset
                
                if Int(self.forecast.currentTemp) <= 32 {
                    self.rainOrSnow.text = "snow"
                } else {
                    self.rainOrSnow.text = "rain"
                }
                
                self.setBackground()
                self.setWeatherAnimation()
            }
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func setBackground() {
    
        let currentBackground = whichBackgroundShouldIUse()
        
        switch (currentBackground)
        {
        case "night":
            weatherBackground = UIColor(hexString: "#333333")
            self.backgroundColor.backgroundColor = weatherBackground
        case "sunUpOrDown":
            backgroundImage.image = UIImage(named: "sunray")
        case "cloudyDay":
            weatherBackground = UIColor.grayColor()
            self.backgroundColor.backgroundColor = weatherBackground
        default:
            weatherBackground = UIColor(hexString: "#06A3FD")
            self.backgroundColor.backgroundColor = weatherBackground
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func setWeatherAnimation() {
        
        stars.stopStars()
        rain.stopRain()
        snow.stopSnow()
        
        //if it's snowing the hills are white.  Otherwise, they are green.  For now.
        hills.image = UIImage(named: "hills")
        
        let icon = self.forecast.currentIcon
        
        if icon == "rain" {
            rain.createParticles(particleView)
        } else if icon == "snow" {
            snow.createParticles(particleView)
            hills.image = UIImage(named: "hills-snowy")
        } else if icon == "partly-cloudy-night" || icon == "clear-night" {
            stars.startStars(particleView)
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func setCurrentCityName(name: String) {
        
        var myCityArray = name.componentsSeparatedByString(",")
        city.setTitle(myCityArray[0].uppercaseString, forState: UIControlState.Normal)
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToSettings") {
            let destination  = segue.destinationViewController as! SettingsViewController
            destination.delegate = self
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func whichBackgroundShouldIUse() -> String {
        
        let icon = self.forecast.currentIcon
        
        let thisTimeZoneOffset = Double(NSTimeZone.systemTimeZone().secondsFromGMT)
        
        let totalTimeZoneOffset = thisTimeZoneOffset - ((timeZoneOffset * 60) * 60)
        
        let now = NSDate.init(timeInterval: -totalTimeZoneOffset, sinceDate: NSDate())
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let nowAsString = dateFormatter.stringFromDate(now)
        
        let curSunrise = dateFormatter.dateFromString(sunrise.text!)
        let curSunset = dateFormatter.dateFromString(sunset.text!)
        let rightNow = dateFormatter.dateFromString(nowAsString)
        
        let sunUp = curSunrise!.timeIntervalSinceDate(rightNow!)
        let sunDown = curSunset!.timeIntervalSinceDate(rightNow!)
 
        if sunUp <= 180.0 && sunUp >= -180 || sunDown <= 180 && sunDown >= -180 {
            return "sunUpOrDown"
        }
        
        if icon == "rain" || icon == "cloudy" || icon == "fog" || icon == "snow" || icon == "sleet" {
            return "cloudyDay"
        }

        if curSunset!.compare(rightNow!) == NSComparisonResult.OrderedAscending ||
           curSunrise!.compare(rightNow!) == NSComparisonResult.OrderedDescending {
            return "night"
        }
        
        return "day"
    }

    
/*-------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------*/
    
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

extension UIImageView {

    func fadeToImage() {
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.alpha = 1.0 },
            completion: nil)
    }
    
    func fadeOutImage() {
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.alpha = 0.0 },
            completion: nil)
    }
}


extension UIView {
    func fadeIn() {
        UIView.animateWithDuration(0.3,
            delay: 0.0,
            options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.alpha = 1.0 },
            completion: nil)
    }
    
    func fadeOut() {
        UIView.animateWithDuration(0.3,
            delay: 0.1,
            options: [UIViewAnimationOptions.CurveEaseOut, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.alpha = 0.0 },
            completion: nil)
    }
    
    func dropIcon(thisView: UIView) {
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.center.y += thisView.bounds.width - 10 },
            completion: nil)

    }
    
    func raiseIcon(thisView: UIView) {
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.2,
            options: [UIViewAnimationOptions.CurveEaseOut, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.center.y -= thisView.bounds.width - 10 },
            completion: nil)
    }
    
    func fadeBackgroundOut() {
        UIView.animateWithDuration(0.7,
            delay: 0,
            options: [UIViewAnimationOptions.CurveEaseOut, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.backgroundColor = UIColor(hexString: "#09679d") },
            completion: nil)
    }
    
    func fadeBackgroundIn(aColor: UIColor) {
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.AllowUserInteraction],
            animations: { self.backgroundColor = aColor },
            completion: nil)
    }

}
/*-------------------------------------------------------------------------------------------------------------*/
//clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night

