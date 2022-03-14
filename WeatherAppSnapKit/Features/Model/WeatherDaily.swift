//
//  WeatherDaily.swift
//  WeatherAppSnapKit
//
//  Created by admin on 13.01.2022.
//

import Foundation

struct WeatherDaily: Codable {
    var date: Int?
    var temperature: Temperature?
    var weather: [WeatherDetail]?
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt", temperature = "temp"
        case weather
    }
}
