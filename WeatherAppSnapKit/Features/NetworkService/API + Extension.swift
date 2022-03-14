//
//  API + Extension.swift
//  WeatherAppSnapKit
//
//  Created by admin on 15.01.2022.
//

import Foundation

struct API {
    
    static let key = "2f630ccafaf35710b2fe43ac11996ff5"
    static let urlWeather = "https://api.openweathermap.org/data/2.5/onecall"
    
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(urlWeather)?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=metric"
    }
    
}
