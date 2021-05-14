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
                normalBackgroundColor: .blue,
                selectedBackgroundColor: .blue,
                disabledBackgroundColor: .blue
            ),
            switchAssets: SwitchAssets(
                isOnColor: .blue,
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