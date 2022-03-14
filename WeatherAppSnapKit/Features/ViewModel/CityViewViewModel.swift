//
//  CityViewViewModel.swift
//  WeatherAppSnapKit
//
//  Created by admin on 13.01.2022.
//

import SwiftUI
import CoreLocation

protocol CityViewViewModelOutputProtocol {
    func fetchCurrentWeather(lat: Double, lon: Double)
    func fetchHourlyWeather(lat:Double, lon: Double)
    func fetchWeeklyWeather(lat:Double, lon: Double)

    func setDelegates(output: WeatherViewControllerOutputProtocol)
    
    var weatherService: Networkable { get }
    var weatherViewControllerOutput: WeatherViewControllerOutputProtocol? { get }
}

final class CityViewViewModel: CityViewViewModelOutputProtocol {
    
    func setDelegates(output: WeatherViewControllerOutputProtocol) {
        weatherViewControllerOutput = output
    }
    
    
    let weatherService: Networkable = NetworkManager()
    var weatherViewControllerOutput: WeatherViewControllerOutputProtocol?
    
    @Published var weatherResponse = WeatherResponse.empty()
    
    @Published var city: String = "Ankara" {
        didSet {
            // CALL GET LOCATİON HERE
//            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
//         getLocation()
    }
    
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherResponse.current?.date ?? 0)))
    }
    
    var weatherCondition: String {
        if let count = weatherResponse.current?.weather?.count {
            if count > 0 {
                return weatherResponse.current?.weather?[0].main ?? ""
            }
        }
        return ""
    }
    
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
}
//MARK: - FetchWeather Methods
extension CityViewViewModel {
    func fetchCurrentWeather(lat: Double, lon: Double) {
        weatherService.fetchCurrentWeather(lat: lat, lon: lon) { [weak self] currentWeatherResponse in
            guard let self = self else { return }
            if let currentResponse = currentWeatherResponse {
                self.weatherViewControllerOutput?.getCurrentWeather(results: currentResponse)
            }
        }
    }
    
    func fetchHourlyWeather(lat: Double, lon: Double) {
        weatherService.fetchHourlyWeather(lat: lat, lon: lon) { [weak self] hourlyWeatherResponse in
            guard let self = self else { return }
            if let hourlyResponse = hourlyWeatherResponse {
                self.weatherViewControllerOutput?.getHourlyWeather(results: hourlyResponse)
            }
        }
    }
    
    func fetchWeeklyWeather(lat: Double, lon: Double) {
        weatherService.fetchWeeklyWeather(lat: lat, lon: lon) { [weak self] weeklyWeatherResponse in
            guard let self = self else { return }
            if let weeklyResponse = weeklyWeatherResponse {
                self.weatherViewControllerOutput?.getWeeklyWeather(results: weeklyResponse)
            }
        }
    }
}
