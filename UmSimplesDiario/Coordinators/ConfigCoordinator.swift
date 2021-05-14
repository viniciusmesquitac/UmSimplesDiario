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
        let navigationController = UINavigationController(
            rootViewController: ConfigViewController(viewModel: ConfigViewModel(coordinator: self)))
        self.currentNavigationController = navigationController
        self.navigationController.present(navigationController, animated: true)
    }

    func route(to route: Route) {
        switch route {
        case .themes:
            let themesViewController = ThemeViewController(viewModel: ThemeViewModel(coordinator: self))
            self.currentNavigationController.pushViewController(themesViewController, animated: true)
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
        let isBackgroundActive = UserDefaults.standard.bool(forKey: DefaultsEnum.isBackgroundThemeActive.rawValue)
        registrosViewController.navigationController?.navigationBar.prefersLargeTitles = !isBackgroundActive
        self.navigationController.popViewController(animated: true)
    }
}
