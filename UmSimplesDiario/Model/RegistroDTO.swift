//
//  Registro.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import Foundation

struct RegistroDTO {
    var titulo: String?
    var texto: String?
    var humor: Humor
    var clima: Clima
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
    var humor: Int16 {
        registro.humor
    }
    var clima: Int16 {
        registro.clima
    }
    
    var dia: String {
        guard let date = registro.date else { return "09" }
        let day = String(calendar.component(.day, from: date))
        return day
    }
    
    var horario: String {
        guard let date = registro.date else { return "12:00" }
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    
    var diaDaSemana: String {
        guard let date = registro.date else { return "12:00" }
        let weekDay = calendar.component(.hour, from: date)
        switch weekDay {
        case 2: return "Mon"; case 3: return "Tue";
        case 4: return "Wed"; case 5: return "Thurs";
        case 6: return "Fri"; case 7: return "Sat";
        case 1: return "Sun";
        default:
            return "Fri"
        }
    }
}
