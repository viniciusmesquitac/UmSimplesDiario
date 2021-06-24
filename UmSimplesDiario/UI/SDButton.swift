//
//  AppButton.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

class SDButton: UIButton {

    var currentColor: UIColor = .darkGray

    @objc dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set (newValue) { layer.cornerRadius = newValue }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                tintColor = currentColor
            } else {
                tintColor = .systemGray2
            }
        }
    }

    @objc dynamic func setBackgroundColor(color: UIColor, for state: UIButton.State) { }

    @objc dynamic func setTintColor(color: UIColor) {
        self.currentColor = color
    }
}
