//
//  RedTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

class RedTheme: ThemeProtocol {

    var assets: Themeable {
        return ThemeAssets(
            labelAssets: LabelAssets(
                textColor: StyleSheet.Color.primaryColor,
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: .red,
                selectedBackgroundColor: .red,
                disabledBackgroundColor: .red,
                tintColor: .red
            ),
            switchAssets: SwitchAssets(
                isOnColor: .red,
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
