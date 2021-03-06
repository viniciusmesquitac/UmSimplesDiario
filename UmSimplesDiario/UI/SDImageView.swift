//
//  SDImageView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 14/05/21.
//

import UIKit

class SDImageView: UIImageView {
    override var tintColor: UIColor? {
        didSet {
            self.layer.borderColor = self.tintColor?.cgColor
        }
    }
}
