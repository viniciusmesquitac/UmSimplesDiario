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
    case weatherCity(name: String, stateCode: String?, countryCode: String?)
    
    var hostname: String {
        get {
            return "http://api.openweathermap.org/data/2.5/"
        }
    }
    
    var url: URL? {
        get {
            switch self {
            case .forecastByCityId: return URL(string: "\(hostname)forecast?id=&appid=\(APISettings.API_KEY)")
                
            case .weatherCity(name: let cityName, stateCode: let stateCode, countryCode: let countryCode):
                return URL(string:"\(hostname)weather?q=\(cityName),\(stateCode ?? ""),\(countryCode ?? "")&appid=\(APISettings.API_KEY)")

            }
        }
    }
}


/*
 func loadWeather() {
     let resource = Resource<WeatherResult>(url: WeatherAPI.weatherCity(name: "Fortaleza", stateCode: nil, countryCode: nil).url!)
     
     URLRequest.load(resource: resource).subscribe(onNext: { result in
         let weather = result?.weather
     }).disposed(by: disposeBag)
 }
 */
