//
//  ThemeProtocol.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import Foundation

protocol ThemeProtocol {
    var assets: Themeable { get }
    var `extension`: (() -> Void)? { get }
}

protocol Themeable {
    var labelAssets: LabelAssets { get }
    var buttonAssets: ButtonAssets { get }
    var switchAssets: SwitchAssets { get }
    // ...
}
