//
//  BlueTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

class BlueTheme: ThemeProtocol {

    var assets: Themeable {
        return ThemeAssets(
            labelAssets: LabelAssets(
                textColor: StyleSheet.Color.primaryColor,
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1),
                selectedBackgroundColor: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1),
                disabledBackgroundColor: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1),
                tintColor: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
            ),
            switchAssets: SwitchAssets(
                isOnColor: #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1),
                isOnDefault: true
            )
        )
    }

    var `extension`: (() -> Void)? {
        return {
            /*Nothing*/
        }
    }
}
