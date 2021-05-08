//
//  RegistrosCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import Foundation

import UIKit

enum RegistrosPath {
    case search(registros: [Registro])
    case compose
    case editCompose(registro: Registro)
    case showIdea(idea: String)
    case config
}

final class RegistrosCoordinator: Coordinator {

    var navigationController: UINavigationController!
    var currentController: RegistrosViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = RegistrosViewModel(coordinator: self, registros: [])
        let registrosViewController = RegistrosViewController(viewModel: viewModel)
        self.currentController = registrosViewController
        navigationController.pushViewController(registrosViewController, animated: true)
    }

    func route(to path: RegistrosPath) {
        switch path {
        case .compose:
            let coordinator = RegistrosCoordinator(navigationController: self.navigationController)
            let viewModel = EscreverDiarioViewModel(coordinator: coordinator, registro: nil)
            let escreverDiarioViewController = EscreverDiarioViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: escreverDiarioViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController.present(navigationController, animated: true, completion: nil)

        case .search(let registros):
            let pesquisarRegistroCoordinator = PesquisarRegistrosCoordinator(
                navigationController: self.navigationController)
            pesquisarRegistroCoordinator.start(registros: registros)

        case .editCompose(let registro):
            let editarRegistoCoordinator = EditarRegistroCoordinator(navigationController: self.navigationController)
            editarRegistoCoordinator.start(registro: registro)

        case .showIdea(let idea):
            let modal = UIAlertAction(title: idea, style: .default, handler: nil)
            print(modal)

        case .config:
            let config = ConfigViewController()
            self.navigationController.present(config, animated: true)
        }
    }

    func dismiss() {
        navigationController.dismiss(animated: true, completion: {
            guard let viewController = self.navigationController
                    .viewControllers.first as? RegistrosViewController
            else { return }
            viewController.viewModel.loadRegistros()
            self.navigationController.popViewController(animated: true)
        })
    }
}
