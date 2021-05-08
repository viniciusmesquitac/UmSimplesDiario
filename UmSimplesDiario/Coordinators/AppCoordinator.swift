//
//  AppCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

final class AppCoordinator: Coordinator, AlertMessage {

    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        coordinateToRegistros()
    }

    private func coordinateToRegistros() {
        if UserDefaults.standard.bool(forKey: DefaultsEnum.isBiometricActive.rawValue) {
            verifyBiometric()
        } else {
            coordinate(to: RegistrosCoordinator(navigationController: navigationController))
        }
    }

    private func verifyBiometric() {
        BiometricAuthentication().identify { success, _ in
            if success {
                self.coordinate(to: RegistrosCoordinator(navigationController: self.navigationController))
            } else {
                self.alert(with: "Desculpe, algo deu errado...", target: self.navigationController) { _ in
                    exit(EXIT_SUCCESS)
                }
            }
        }
    }

}
