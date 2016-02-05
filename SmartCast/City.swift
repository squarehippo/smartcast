//
//  City.swift
//  SmartCast
//
//  Created by Brian Wilson on 1/30/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit
import AVFoundation

class City {
    private var _name: String
    private var _state: String
    private var _latitude: String
    private var _longitude: String
    
    var name: String {
        return _name
    }
    
    var state: String {
        return _state
    }
    
    var latitude: String {
        return _latitude
    }
    
    var longitude: String {
        return _longitude
    }
    
    init(name: String, state: String, latitude: String, longitude: String) {
        _name = name
        _state = state
        _latitude = latitude
        _longitude = longitude
    }
    
    
}
