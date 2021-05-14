//
//  BlueTheme.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

class BlueTheme: ThemeProtocol {

    var assets: Themeable {
        return ThemeAssets(
            labelAssets: LabelAssets(
                textColor: .blue,
                font: .systemFont(ofSize: 12, weight: .black)
            ),
            buttonAssets: ButtonAssets(
                normalBackgroundColor: .black,
                selectedBackgroundColor: .red,
                disabledBackgroundColor: .black
            ),
            switchAssets: SwitchAssets(
                isOnColor: .blue,
                isOnDefault: true
            )
        )
    }

    var `extension`: (() -> Void)? {
        return {
            let proxy = SDButton.appearance(whenContainedInInstancesOf: [SDView.self])
            proxy.cornerRadius = 12.0
            proxy.setBackgroundColor(color: .blue, for: .normal)
        }
    }

//    var `extension`: (() -> Void)? {
//        return {

//        }
//    }
}
