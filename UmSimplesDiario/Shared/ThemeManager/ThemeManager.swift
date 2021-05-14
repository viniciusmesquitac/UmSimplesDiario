//
//  ThemeManager.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

struct ThemeManager {

    static let shared = ThemeManager()

    private init() { }

    func apply(_ theme: Theme) {
        // 1
        let appTheme = theme.appTheme
        // 2
        updateLabel(using: appTheme.assets.labelAssets)
        updateBarButtonItem(using: appTheme.assets.buttonAssets)
        updateNavbar(using: appTheme.assets.buttonAssets)
        // 3
        appTheme.extension?()
        // 4
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first

        keyWindow?.reload()
    }

    func updateLabel(using themeAssets: LabelAssets) {
        SDLabel.appearance().textColor = themeAssets.textColor
    }

    func updateButton(using themeAssets: ButtonAssets) {
        SDButton.appearance().backgroundColor = themeAssets.normalBackgroundColor
    }

    func updateBarButtonItem(using themeAssets: ButtonAssets) {
        SDBarButtonItem.appearance().tintColor = themeAssets.normalBackgroundColor
    }

    func updateNavbar(using themeAssets: ButtonAssets) {
        UINavigationBar.appearance().tintColor = themeAssets.normalBackgroundColor
        UITabBar.appearance().barTintColor = themeAssets.normalBackgroundColor
    }
}
