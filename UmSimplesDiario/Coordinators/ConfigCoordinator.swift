//
//  ConfigCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

final class ConfigCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var currentNavigationController: UINavigationController!

    enum Route {
        case themes
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.currentNavigationController = UINavigationController()
    }

    func start() {
        let controller = ConfigViewController(viewModel: ConfigViewModel(coordinator: self))
        self.navigationController.pushViewController(controller, animated: true)
    }

    func route(to route: Route) {
        switch route {
        case .themes:
            let themesViewController = ThemeViewController(viewModel: ThemeViewModel(coordinator: self))
            self.navigationController.pushViewController(themesViewController, animated: true)
        }
    }

    func dismiss() {
        currentNavigationController.dismiss(animated: true, completion: {
            let firstViewController = self.navigationController.viewControllers.first
            guard let registrosViewController =  firstViewController as? RegistrosViewController else { return }
            registrosViewController.viewModel.loadRegistros()
            self.navigationController.popViewController(animated: true)
        })
    }

    func updateBackground() {
        let firstViewController = self.navigationController.viewControllers.first
        guard let registrosViewController = firstViewController as? RegistrosViewController else { return }
        StyleSheet.Color.activeButtonColor = .brown
        registrosViewController.mainView.updateBackground()
    }
}
