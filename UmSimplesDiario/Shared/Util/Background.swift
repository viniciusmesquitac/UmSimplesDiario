//
//  Background.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/06/21.
//

import Foundation

enum BackgroudType {
    case lightMode
    case darkMode
    case systemMode
}

enum Background: String, CaseIterable {
    case noneBackground
    case blueSkyBackground
    case pinkGalaxyBackground
    case darkGalaxyBackground
    case orangeBackground
    
    var type: BackgroudType {
        switch self {
        case .blueSkyBackground: return .darkMode
        case .pinkGalaxyBackground: return .lightMode
        case .darkGalaxyBackground: return .darkMode
        case .orangeBackground: return .darkMode
        default:
            return .systemMode
        }
    }
}
