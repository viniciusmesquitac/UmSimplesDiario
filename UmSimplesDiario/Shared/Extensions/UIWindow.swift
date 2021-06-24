//
//  UIWindow.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

public extension UIWindow {

    /// Unload all views and add them back
    /// Used for applying `UIAppearance` changes to existing views
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
