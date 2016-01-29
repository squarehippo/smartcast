//
//  SettingsViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/28/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit
import MapKit




func setUsersClosestCity()
{
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: 36.073522, longitude: -79.116669)
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
                print(city)
            }
            
    }
}
