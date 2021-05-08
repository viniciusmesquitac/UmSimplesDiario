//
//  RegistroRepository.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 10/02/21.
//

import Foundation

protocol Repository {
    associatedtype ObjectDTO
    associatedtype Object

    func getAll() -> [Object]
    func get(object: Object) -> Object?
    func add(object: ObjectDTO) -> Object?
    func delete(object: Object) -> Object?
}

class RegistroRepository: Repository {

    let service = CoreDataService<Registro>()
    var registros: [Registro] = []

    typealias ObjectDTO = RegistroDTO
    typealias Object = Registro

    func getAll() -> [Registro] {
        guard let registros = service.fetchAll() else { return self.registros }
        self.registros = registros
        return registros
    }

    @discardableResult
    func add(object: RegistroDTO) -> Registro? {
        let registro = service.new()
        registro?.texto = object.text
        registro?.titulo = object.title
        registro?.clima = object.weather.index
        registro?.humor = object.mood.rawValue
        registro?.date = object.date
        if service.save() { return registro }
        return nil
    }

    func get(object: Registro) -> Registro? {
        nil
    }

    func save(object: Registro) {
        _ = service.save()
    }

    @discardableResult
    func delete(object: Registro) -> Registro? {
        service.delete(object: object)
    }

}
