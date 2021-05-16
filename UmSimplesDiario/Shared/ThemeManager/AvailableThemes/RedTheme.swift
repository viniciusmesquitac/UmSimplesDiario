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
                normalBackgroundColor: #colorLiteral(red: 1, green: 0.2324135602, blue: 0.2480118871, alpha: 1),
                selectedBackgroundColor: #colorLiteral(red: 1, green: 0.2324135602, blue: 0.2480118871, alpha: 1),
                disabledBackgroundColor: #colorLiteral(red: 1, green: 0.2324135602, blue: 0.2480118871, alpha: 1),
                tintColor: #colorLiteral(red: 1, green: 0.2324135602, blue: 0.2480118871, alpha: 1)
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
