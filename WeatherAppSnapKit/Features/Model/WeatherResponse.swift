//
//  WeatherResponse.swift
//  WeatherAppSnapKit
//
//  Created by admin on 13.01.2022.
//

import Foundation

struct WeatherResponse: Codable {
    var current: Weather?
    var hourly: [Weather]?
    var daily: [WeatherDaily]?
    
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [WeatherDaily](repeating: WeatherDaily(), count: 8))
    }
}
