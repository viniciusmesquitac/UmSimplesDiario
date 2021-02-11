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
    
    var semana: String?
    var dia: String?
    var horario: String?
    
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
    
}
