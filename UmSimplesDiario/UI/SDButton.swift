//
//  AppButton.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

class SDButton: UIButton {
    @objc dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set (newValue) { layer.cornerRadius = newValue }
    }

    @objc dynamic func setBackgroundColor(color: UIColor, for state: UIButton.State) {
    }
}
