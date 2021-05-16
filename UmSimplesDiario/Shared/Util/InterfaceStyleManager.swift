//
//  Settings.swift
//  memo
//
//  Created by Elias Ferreira on 14/03/21.
//  Copyright © 2021 Academy IFCE. All rights reserved.
//
import UIKit

enum ConfigKeys: String {
    case style
    case theme
    case background
}

class InterfaceStyleManager {
    private var userDefaults: UserDefaults
    static let shared = InterfaceStyleManager()

    private init () {
        userDefaults = UserDefaults.standard
    }

    var style: UIUserInterfaceStyle {
        get {
            if let rawValue = userDefaults.value(forKey: ConfigKeys.style.rawValue) as? Int {
               return UIUserInterfaceStyle(rawValue: rawValue)!
            }
            return .unspecified
        }

        set {
            userDefaults.setValue(newValue.rawValue, forKey: ConfigKeys.style.rawValue)
        }
    }

    var theme: Theme {
        get {
            if let rawValue = userDefaults.value(forKey: ConfigKeys.theme.rawValue) as? Int {
               return Theme(rawValue: rawValue)!
            }
            return .blue
        }

        set {
            userDefaults.setValue(newValue.rawValue, forKey: ConfigKeys.theme.rawValue)
        }
    }

    var background: Background {
        get {
            if let rawValue = userDefaults.value(forKey: ConfigKeys.background.rawValue) as? String {
               return Background(rawValue: rawValue)!
            }
            return .noneBackground
        }

        set {
            userDefaults.setValue(newValue.rawValue, forKey: ConfigKeys.background.rawValue)
        }
    }
}
