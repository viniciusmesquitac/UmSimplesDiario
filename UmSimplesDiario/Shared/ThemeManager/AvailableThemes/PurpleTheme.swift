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
                textColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                selectedBackgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                disabledBackgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                tintColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
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
