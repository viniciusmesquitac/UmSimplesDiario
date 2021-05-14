//
//  AppTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

enum Theme {
    case red
    case green
    case blue
}

extension Theme {

    var appTheme: ThemeProtocol {
        switch self {
            case .red: return BlueTheme()
            case .green: return BlueTheme()
            case .blue: return BlueTheme()
        }
    }

}
