//
//  ThemeManager.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

struct ThemeManager {

    func apply(_ theme: Theme) {
        // 1
        let appTheme = theme.appTheme
        // 2
        updateLabel(using: appTheme.assets.labelAssets)
        updateBarButtonItem(using: appTheme.assets.buttonAssets)
        updateNavbar(using: appTheme.assets.buttonAssets)
        updateButton(using: appTheme.assets.buttonAssets)
        updateImageView(using: appTheme.assets.buttonAssets)
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
        SDButton.appearance().tintColor = themeAssets.tintColor
        SDButton.appearance().setTintColor(color: themeAssets.tintColor, for: .selected)
    }

    func updateBarButtonItem(using themeAssets: ButtonAssets) {
        SDBarButtonItem.appearance().tintColor = themeAssets.tintColor
    }

    func updateImageView(using themeAssets: ButtonAssets) {
        SDImageView.appearance().tintColor = themeAssets.tintColor
    }

    func updateNavbar(using themeAssets: ButtonAssets) {
        UINavigationBar.appearance().tintColor = themeAssets.tintColor
    }
}
