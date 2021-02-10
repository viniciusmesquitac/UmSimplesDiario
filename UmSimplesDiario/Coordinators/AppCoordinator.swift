//
//  AppCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    
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
        let registrosCoordinator = RegistrosCoordinator(navigationController: navigationController)
        registrosCoordinator.start()
    }
    
}
