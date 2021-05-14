//
//  PurpleTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

class PurpleTheme: ThemeProtocol {

    var assets: Themeable {
        return ThemeAssets(
            labelAssets: LabelAssets(
                textColor: StyleSheet.Color.primaryColor,
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: .brown,
                selectedBackgroundColor: .black,
                disabledBackgroundColor: .black
            ),
            switchAssets: SwitchAssets(
                isOnColor: .purple,
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
