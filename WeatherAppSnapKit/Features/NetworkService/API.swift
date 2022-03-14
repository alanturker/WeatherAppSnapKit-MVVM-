//
//  API.swift
//  WeatherAppSnapKit
//
//  Created by admin on 12.01.2022.
//

import Foundation
import Moya

enum WeatherAPI {
    case location(lat: Double, lon: Double)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: API.urlWeather) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .location(_, _):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .location(_, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .location(lat: let lat, lon: let lon):
            return .requestParameters(parameters: ["lat": lat, "lon": lon, "exclude": "minutely", "units": "metric", "appid": API.key], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
