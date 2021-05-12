//
//  AlertMessage.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

protocol AlertMessage {
    func alert(with message: String, target: UINavigationController, handler: ((UIAlertAction) -> Void)?)
}

extension AlertMessage {
    func alert(with message: String, target: UINavigationController, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Algo de errado!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Finalizar", style: .default, handler: handler))
        target.present(alertController, animated: true)
    }
}
