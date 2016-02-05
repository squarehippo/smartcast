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
    private var _currentDay: String!
    private var _currentIcon: String!
    private var _currentSunriseTime: String!
    private var _currentSunsetTime: String!
    private var _currentPrecipProbability: String!
    private var _currentTimeZoneOffset: Int!
    private var _windSpeed: String!
    private var _windBearing: String!
    private var _weatherSummary: String!
    private let _weatherURL: String!
    private var _day1MaxTemp: String!
    private var _day1MinTemp: String!
    private var _day2MaxTemp: String!
    private var _day2MinTemp: String!
    private var _day3MaxTemp: String!
    private var _day3MinTemp: String!
    private var _day4MaxTemp: String!
    private var _day4MinTemp: String!
    private var _day5MaxTemp: String!
    private var _day5MinTemp: String!
    private var _day1Icon: String!
    private var _day2Icon: String!
    private var _day3Icon: String!
    private var _day4Icon: String!
    private var _day5Icon: String!
    private var _day1Name: String!
    private var _day2Name: String!
    private var _day3Name: String!
    private var _day4Name: String!
    private var _day5Name: String!
    
    
    var currentCity: String {
        if _currentCity != nil {
            return _currentCity!
        } else {
            return "HILLSBOROUGH"
        }
    }
    
    var currentIcon: String {
        return _currentIcon
    }
    
    var currentSunriseTime: String {
        return _currentSunriseTime
    }
    
    var currentSunsetTime: String {
        return _currentSunsetTime
    }
    
    var currentPrecipProbability: String {
        return _currentPrecipProbability
    }
    
    var currentTimeZoneOffset: Int {
        return _currentTimeZoneOffset
    }
    
    var day1MaxTemp: String {
        return _day1MaxTemp
    }
    
    var day1MinTemp: String {
        return _day1MinTemp
    }
    
    var day2MaxTemp: String {
        return _day2MaxTemp
    }
    
    var day2MinTemp: String {
        return _day2MinTemp
    }

    var day3MaxTemp: String {
        return _day3MaxTemp
    }
    
    var day3MinTemp: String {
        return _day3MinTemp
    }

    var day4MaxTemp: String {
        return _day4MaxTemp
    }
    
    var day4MinTemp: String {
        return _day4MinTemp
    }

    var day5MaxTemp: String {
        return _day5MaxTemp
    }
    
    var day5MinTemp: String {
        return _day5MinTemp
    }
    
    var day1Name: String {
        return _day1Name
    }
    
    var day2Name: String {
        return _day2Name
    }
    
    var day3Name: String {
        return _day3Name
    }
    
    var day4Name: String {
        return _day4Name
    }
    
    var day5Name: String {
        return _day5Name
    }

    var day1Icon: String {
        return _day1Icon
    }
    
    var day2Icon: String {
        return _day2Icon
    }
    
    var day3Icon: String {
        return _day3Icon
    }
    
    var day4Icon: String {
        return _day4Icon
    }
    
    var day5Icon: String {
        return _day5Icon
    }

    var windBearing: String {
        return _windBearing
    }
    
    var windSpeed: String {
        return _windSpeed
    }
    
    var currentTemp: String {
        return _currentTemp
    }
    
    var weatherSummary: String {
        return _weatherSummary
    }
    
    var fiveDayArray = [Double]()
    
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
                        
                        
                        //Current weather information
                        guard let dict = json as? NSDictionary,
                            let curForecast = dict["currently"] as? Dictionary<String, AnyObject>,
                            let curTemp = curForecast["temperature"] as? Double else {
                            return
                        }
                        //Today's temperature
                        self._currentTemp = String(format: "%.0f", curTemp)
                        
                        //Today's summary
                        guard let curSummary = curForecast["summary"] as? String else {
                            return
                        }
                        self._weatherSummary = "Currently \(curSummary.lowercaseString)"
                        
                        //Today's time zone offset
                        guard let curTimeZoneOffset = dict["offset"] as? Int else {
                            print("try again")
                            return
                        }
                        self._currentTimeZoneOffset = curTimeZoneOffset
                        
                        //Today's icon
                        guard let curIcon = curForecast["icon"] as? String else {
                            return
                        }
                        self._currentIcon = curIcon
                    
                        //Today's wind speed
                        guard let curWindSpeed = curForecast["windSpeed"] as? Int else {
                            return
                        }
                        self._windSpeed = String(curWindSpeed)
                        
                        //Today's wind bearing
                        guard let curWindBearing = curForecast["windBearing"] as? Int else {
                            return
                        }
                        let curBearing = String(curWindBearing)
                        if curBearing != "" {
                            let tempWindBearing = self.translateWindBearing(Int(curBearing)!)
                            self._windBearing = tempWindBearing
                        } else {
                            self._windBearing = ""
                        }
                        
                        
                        guard let curDetails = dict["daily"] as? Dictionary<String, AnyObject>,
                              let dailyDetails = curDetails["data"] as? [Dictionary<String, AnyObject>],
                              let max1Temp = dailyDetails[1]["temperatureMax"] as? Double,
                              let min1Temp = dailyDetails[1]["temperatureMin"] as? Double,
                              let max2Temp = dailyDetails[2]["temperatureMax"] as? Double,
                              let min2Temp = dailyDetails[2]["temperatureMin"] as? Double,
                              let max3Temp = dailyDetails[3]["temperatureMax"] as? Double,
                              let min3Temp = dailyDetails[3]["temperatureMin"] as? Double,
                              let max4Temp = dailyDetails[4]["temperatureMax"] as? Double,
                              let min4Temp = dailyDetails[4]["temperatureMin"] as? Double,
                              let max5Temp = dailyDetails[5]["temperatureMax"] as? Double,
                              let min5Temp = dailyDetails[5]["temperatureMin"] as? Double else {
                            return
                        }
                        
                            //Weekly max & min temp
                            self._day1MaxTemp = String(format: "%.0f", max1Temp)
                            self._day1MinTemp = String(format: "%.0f", min1Temp)
                            self._day2MaxTemp = String(format: "%.0f", max2Temp)
                            self._day2MinTemp = String(format: "%.0f", min2Temp)
                            self._day3MaxTemp = String(format: "%.0f", max3Temp)
                            self._day3MinTemp = String(format: "%.0f", min3Temp)
                            self._day4MaxTemp = String(format: "%.0f", max4Temp)
                            self._day4MinTemp = String(format: "%.0f", min4Temp)
                            self._day5MaxTemp = String(format: "%.0f", max5Temp)
                            self._day5MinTemp = String(format: "%.0f", min5Temp)
                        
                        //Daily icons for five days
                        guard let curDay1Icon = dailyDetails[1]["icon"] as? String,
                              let curDay2Icon = dailyDetails[2]["icon"] as? String,
                              let curDay3Icon = dailyDetails[3]["icon"] as? String,
                              let curDay4Icon = dailyDetails[4]["icon"] as? String,
                              let curDay5Icon = dailyDetails[5]["icon"] as? String else {
                            return
                        }
                            self._day1Icon = self.formatIcon(curDay1Icon)
                            self._day2Icon = self.formatIcon(curDay2Icon)
                            self._day3Icon = self.formatIcon(curDay3Icon)
                            self._day4Icon = self.formatIcon(curDay4Icon)
                            self._day5Icon = self.formatIcon(curDay5Icon)
                        
                        guard let curDay1Time = dailyDetails[1]["time"] as? Double,
                            let curDay2Time = dailyDetails[2]["time"] as? Double,
                            let curDay3Time = dailyDetails[3]["time"] as? Double,
                            let curDay4Time = dailyDetails[4]["time"] as? Double,
                            let curDay5Time = dailyDetails[5]["time"] as? Double else {
                                return
                        }
                            self._day1Name = self.getDayOfWeek(curDay1Time)
                            self._day2Name = self.getDayOfWeek(curDay2Time)
                            self._day3Name = self.getDayOfWeek(curDay3Time)
                            self._day4Name = self.getDayOfWeek(curDay4Time)
                            self._day5Name = self.getDayOfWeek(curDay5Time)
                        
                        //Current sunrise and sunset times
                        guard let curSunriseTime = dailyDetails[0]["sunriseTime"] as? Double,
                              let curSunsetTime = dailyDetails[0]["sunsetTime"] as? Double else {
                            return
                        }
                            self._currentSunriseTime = self.convertUNIXTime(curSunriseTime)
                            self._currentSunsetTime = self.convertUNIXTime(curSunsetTime)
                        
                        //Precipitation probability
                        guard let curPrecipProbability = dailyDetails[0]["precipProbability"] as? Double else {
                                return
                        }
                            self._currentPrecipProbability = "\(Int(curPrecipProbability * 100))%"
                        
                        //Summary for the week
//                        guard let dailySummary = dailyDetails[0]["summary"] as? String else {
//                            return
//                        }
//                            self._weatherSummary = dailySummary

                        

                        completed()
                        
                        
                        
                    } catch {
                        print("whoops")
                    }
                }             }
            task.resume()
        }
        
    }
    
    func formatIcon(icon: String) -> String {
        if icon == "partly-cloudy-night" {
            return "partly-cloudy-day-small"
        } else {
            return "\(icon)-small"
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
    
    func getDayOfWeek(time: Double) -> String? {
        
        let curDate = NSDate(timeIntervalSince1970: time)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let justTheDate = dateFormatter.stringFromDate(curDate)

        if let todayDate = dateFormatter.dateFromString(justTheDate) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
       
            switch weekDay {
            case 1:
                return "SUN"
            case 2:
                return "MON"
            case 3:
                return "TUE"
            case 4:
                return "WED"
            case 5:
                return "THU"
            case 6:
                return "FRI"
            case 7:
                return "SAT"
            default:
                print("Error fetching days")
                return "Day"
            }

        } else {
            print("no dice")
            return nil
            
        }
    }
    
    func translateWindBearing(bearing: Int) -> String {
        switch bearing {
        case 0...11:
            return "n"
        case 12...33:
            return "nne"
        case 34...55:
            return "ne"
        case 56...78:
            return "ene"
        case 79...101:
            return "e"
        case 102...123:
            return "ese"
        case 124...146:
            return "se"
        case 147...168:
            return "sse"
        case 169...191:
            return "s"
        case 192...213:
            return "ssw"
        case 214...236:
            return "sw"
        case 237...258:
            return "wsw"
        case 259...281:
            return "w"
        case 282...303:
            return "wnw"
        case 304...326:
            return "nw"
        case 327...348:
            return "nnw"
        case 349...360:
            return "n"
        default:
            print("Error fetching wind bearing")
            return ""
        }

    }
    
    func convertUNIXTime(time: Double) -> String {
        
        let curTime = NSDate(timeIntervalSince1970: time)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let justTheTime = dateFormatter.stringFromDate(curTime)
      
       return justTheTime
        
    }


    
    
}