//
//  AppTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

enum Theme: Int, CaseIterable {
    case blue
    case red
    case pink
    case purple
}

extension Theme {

    var appTheme: ThemeProtocol {
        switch self {
        case .blue:
            return BlueTheme()
        case .red:
            return RedTheme()
        case .pink:
            return PinkTheme()
        case .purple:
            return PurpleTheme()
        }
    }
}
