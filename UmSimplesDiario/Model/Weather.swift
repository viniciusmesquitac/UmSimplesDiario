//
//  Weather.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import Foundation

enum WeatherKeyResult: String, CaseIterable {
    case clearSky = "clear sky"
    case fewClounds = "few clouds"
    case brokenClounds = "broken clouds"
    case scatteredClounds = "scattered clouds"
    case rain = "rain"
    case thunderstorm
    case moderateRain = "moderate rain"
    case showerRain = "shower rain"
    case none
    
    var index: Int16 {
        return Int16(WeatherKeyResult.allCases.firstIndex(of: self)!)
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherResult: Decodable {
    let weather: [Weather]
}
