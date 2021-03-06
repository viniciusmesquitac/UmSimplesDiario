//
//  Registro.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import Foundation
import UIKit

struct RegistroDTO {
    var title: String?
    var text: String?
    var mood: Mood
    var weather: WeatherKeyResult
    let date = Date()
}

struct RegistroModel {
    let registro: Registro
    let calendar = Calendar.current

    init(registro: Registro) {
        self.registro = registro
    }
}

extension RegistroModel {
    var titulo: String? {
        registro.titulo
    }
    var texto: String? {
        registro.texto
    }
    var humor: UIImage? {
        switch registro.humor {
        case 0: return StyleSheet.Image.happyMood
        case 1: return StyleSheet.Image.sadMood
        default: return nil
        }
    }

    var weather: UIImage? {
        let imageNamed = WeatherKeyResult.allCases[Int(registro.clima)]
            .rawValue.replacingOccurrences(of: " ", with: "_")
        return UIImage(named: imageNamed)
    }

    var day: String {
        guard let date = registro.date else { return "09" }
        let day = String(calendar.component(.day, from: date))
        return day
    }

    var month: Int {
        guard let date = registro.date else { return 0 }
        let month = calendar.component(.month, from: date)
        return month - 1
    }

    var time: String {
        guard let date = registro.date else { return "12:00" }
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        if minutes < 10 {
            return "\(hour):0\(minutes)"
        }
        return "\(hour):\(minutes)"
    }
    var daysOfWeek: String {
        guard let date = registro.date else { return "12:00" }
        let weekDay = calendar.component(.weekday, from: date)
        switch weekDay {
        case 2: return "Seg"
        case 3: return "Ter"
        case 4: return "Qua"
        case 5: return "Qui"
        case 6: return "Sex"
        case 7: return "Sáb"
        case 1: return "Dom"
        default:
            return "Seg"
        }
    }
}
