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
        let registrosViewController = RegistrosViewController(viewModel: RegistrosViewModel(coordinator: RegistrosCoordinator(navigationController: navigationController), registros: [Registro(), Registro(), Registro()]))
        self.navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(registrosViewController, animated: false)
    }
    
}
