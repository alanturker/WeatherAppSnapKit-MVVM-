//
//  NetworkManager.swift
//  WeatherAppSnapKit
//
//  Created by admin on 12.01.2022.
//

import Foundation
import Moya

typealias currentWeatherCompletion = (CurrentWeatherModel?) -> ()
typealias hourlyWeatherCompletion = (HourlyWeatherModel?) -> ()
typealias weeklyWeatherCompletion = (WeeklyWeatherModel?) -> ()

protocol Networkable: AnyObject {
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping currentWeatherCompletion)
    func fetchHourlyWeather(lat: Double, lon: Double, completion: @escaping hourlyWeatherCompletion)
    func fetchWeeklyWeather(lat: Double, lon: Double, completion: @escaping weeklyWeatherCompletion)
}

class NetworkManager: Networkable {
    
    private var provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin()])
    
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping currentWeatherCompletion) {
        provider.request(.location(lat: lat, lon: lon)) { locationResult in
            switch locationResult {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    let weatherObject = CurrentWeatherModel(current: results.current)
                    completion(weatherObject)
                    
                } catch let error {
                    print("Fetching error at searching movies: \(error)")
                    completion(nil)
                }
                
            case .failure(let serverError):
                print("serverError: \(serverError)")
                completion(nil)
            }
        }
    }
    
    func fetchHourlyWeather(lat: Double, lon: Double, completion: @escaping hourlyWeatherCompletion) {
        provider.request(.location(lat: lat, lon: lon)) { locationResult in
            switch locationResult {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    let weatherObject = HourlyWeatherModel(hourly: results.hourly)
                    completion(weatherObject)
                    
                } catch let error {
                    print("Fetching error at searching movies: \(error)")
                    completion(nil)
                }
                
            case .failure(let serverError):
                print("serverError: \(serverError)")
                completion(nil)
            }
        }
    }
    
    func fetchWeeklyWeather(lat: Double, lon: Double, completion: @escaping weeklyWeatherCompletion) {
        provider.request(.location(lat: lat, lon: lon)) { locationResult in
            switch locationResult {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    let weatherObject = WeeklyWeatherModel(daily: results.daily)
                    completion(weatherObject)
                    
                } catch let error {
                    print("Fetching error at searching movies: \(error)")
                    completion(nil)
                }
                
            case .failure(let serverError):
                print("serverError: \(serverError)")
                completion(nil)
            }
        }
    }
    
    
}
