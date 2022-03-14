//
//  Weather.swift
//  WeatherAppSnapKit
//
//  Created by admin on 12.01.2022.
//

import Foundation

struct Weather: Codable {
    var date: Int?
    var temperature: Double?
    var feelsLike: Double?
    var pressure: Int?
    var humidity: Int?
    var dew_point: Double?
    var clouds: Int?
    var windSpeed: Double?
    var windDegree: Int?
    var weather: [WeatherDetail]?
    
    private enum CodingKeys: String, CodingKey {
        case pressure, humidity, dew_point, clouds, weather
        case date = "dt", temperature = "temp", feelsLike = "feels_like", windDegree = "wind_deg", windSpeed = "wind_speed"
    }
}
