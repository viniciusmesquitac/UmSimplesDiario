//
//  RegistrosCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import Foundation

import UIKit

enum RegistrosPath {
    case search
    case compose
}

final class RegistrosCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registroViewController = RegistrosViewController(viewModel: RegistrosViewModel(coordinator: self, registros: []))
        navigationController.pushViewController(registroViewController, animated: true)
    }
    
    func route(to Path: RegistrosPath) {
        switch Path {
        case .compose:
            let escreverDiarioViewController = EscreverDiarioViewController(viewModel: EscreverDiarioViewModel(coordinator: RegistrosCoordinator(navigationController: self.navigationController)))
            
            let navigationController = UINavigationController(rootViewController: escreverDiarioViewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            self.navigationController.present(navigationController, animated: true, completion: nil)
        case .search:
            let pesquisarRegistrosViewController = PesquisarRegistrosViewController()
            self.navigationController.present(pesquisarRegistrosViewController, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
