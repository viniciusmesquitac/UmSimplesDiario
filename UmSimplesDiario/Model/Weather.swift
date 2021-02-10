//
//  Weather.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import Foundation

enum Clima: Int16 {
    case chuvoso
    case ensolarado
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
