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
    case editCompose(registro: Registro)
}

final class RegistrosCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    var currentController: RegistrosViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registrosViewController = RegistrosViewController(viewModel: RegistrosViewModel(coordinator: self, registros: []))
        self.currentController = registrosViewController
        navigationController.pushViewController(registrosViewController, animated: true)
    }
    
    func route(to Path: RegistrosPath) {
        switch Path {
        case .compose:
            let escreverDiarioViewController = EscreverDiarioViewController(viewModel: EscreverDiarioViewModel(coordinator: RegistrosCoordinator(navigationController: self.navigationController), registro: nil))
            
            let navigationController = UINavigationController(rootViewController: escreverDiarioViewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            self.navigationController.present(navigationController, animated: true, completion: nil)
        case .search:
            let pesquisarRegistrosViewController = PesquisarRegistrosViewController(viewModel: PesquisarRegistrosViewModel(coordinator: RegistrosCoordinator(navigationController: self.navigationController)))
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController.present(pesquisarRegistrosViewController, animated: true, completion: nil)
            
        case .editCompose(let registro):
            let escreverDiarioViewController = EscreverDiarioViewController(viewModel: EscreverDiarioViewModel(coordinator: RegistrosCoordinator(navigationController: self.navigationController), registro: registro))
            escreverDiarioViewController.navigationController?.title = ""
            escreverDiarioViewController.navigationController?.navigationBar.prefersLargeTitles = false
            escreverDiarioViewController.navigationController?.navigationItem.largeTitleDisplayMode = .never
            self.navigationController.pushViewController(escreverDiarioViewController, animated: true)
        }
        
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: {
            guard let vc = self.navigationController.viewControllers.first as? RegistrosViewController else { return }
            vc.viewModel.loadRegistros()
            self.navigationController.popViewController(animated: true)
        })
    }
}
