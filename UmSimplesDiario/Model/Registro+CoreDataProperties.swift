//
//  Registro+CoreDataProperties.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 19/02/21.
//
//

import Foundation
import CoreData

// swiftlint:disable all
extension Registro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registro> {
        return NSFetchRequest<Registro>(entityName: "Registro")
    }

    @NSManaged public var clima: Int16
    @NSManaged public var date: Date?
    @NSManaged public var humor: Int16
    @NSManaged public var texto: String?
    @NSManaged public var titulo: String?

}

extension Registro : Identifiable {

}
