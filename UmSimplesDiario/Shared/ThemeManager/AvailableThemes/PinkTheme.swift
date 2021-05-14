//
//  PinkTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

class PinkTheme: ThemeProtocol {

    var assets: Themeable {
        return ThemeAssets(
            labelAssets: LabelAssets(
                textColor: StyleSheet.Color.primaryColor,
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: .purple,
                selectedBackgroundColor: .purple,
                disabledBackgroundColor: .purple
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
