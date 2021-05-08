//
//  WeatherAPI.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import Foundation

protocol Router {
    var hostname: String { get }
    var url: URL? { get }
}

enum WeatherAPI: Router {

    case forecastByCityId
    case weatherCity(name: String, stateCode: String = "", countryCode: String = "")

    var hostname: String {
            return "http://api.openweathermap.org/data/2.5/"
    }

    var url: URL? {
            switch self {
            case .forecastByCityId: return URL(string: "\(hostname)forecast?id=&appid=\(APISettings.API_KEY)")
            case .weatherCity(
                    name: let cityName,
                    stateCode: let stateCode,
                    countryCode: let countryCode):
                let queries: [String] = ["\(cityName)", "\(stateCode)", "\(countryCode)"]
                let value = "\(hostname)weather?q=\(queries.joined(separator: ","))&appid=\(APISettings.API_KEY)"
                return URL( string: value)

            }
    }
}
