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
        let pesquisarRegistrosViewController = PesquisarRegistrosViewController(viewModel: PesquisarRegistrosViewModel(coordinator: self, registros: registros))
        
        currentNavigationController.setViewControllers([pesquisarRegistrosViewController], animated: false)
        currentNavigationController.modalPresentationStyle = .fullScreen
        self.navigationController.present(currentNavigationController, animated: true)
       
    }
    
    func editCompose(registro: Registro) {
        let escreverDiarioViewController = EscreverDiarioViewController(viewModel: EscreverDiarioViewModel(coordinator: RegistrosCoordinator(navigationController: self.navigationController), registro: registro))
        escreverDiarioViewController.navigationController?.title = ""
        escreverDiarioViewController.navigationController?.navigationBar.prefersLargeTitles = false
        escreverDiarioViewController.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.currentNavigationController.pushViewController(escreverDiarioViewController, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: {
            guard let vc = self.navigationController.viewControllers.first as? RegistrosViewController else { return }
            vc.viewModel.loadRegistros()
            self.navigationController.popViewController(animated: true)
        })
    }
}
