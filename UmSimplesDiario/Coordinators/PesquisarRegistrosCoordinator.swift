//
//  PesquisarRegistrosCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 16/02/21.
//

import Foundation

import UIKit

final class PesquisarRegistrosCoordinator: Coordinator {
    func start() { }
    var navigationController: UINavigationController!
    var currentNavigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.currentNavigationController = UINavigationController()
    }

    func start(registros: [Registro]) {
        let viewModel = PesquisarRegistrosViewModel(coordinator: self, registros: registros)
        let pesquisarRegistrosViewController = PesquisarRegistrosViewController(viewModel: viewModel)
        currentNavigationController.setViewControllers([pesquisarRegistrosViewController], animated: false)
        currentNavigationController.modalPresentationStyle = .overFullScreen
        currentNavigationController.modalTransitionStyle = .crossDissolve
        self.navigationController.present(currentNavigationController, animated: true)
    }

    func editCompose(registro: Registro) {
        let editarRegistoCoordinator = EditarRegistroCoordinator(navigationController: self.currentNavigationController)
        editarRegistoCoordinator.start(registro: registro)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
