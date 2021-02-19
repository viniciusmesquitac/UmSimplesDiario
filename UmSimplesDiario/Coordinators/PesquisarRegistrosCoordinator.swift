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

        let coordinator = RegistrosCoordinator(navigationController: self.navigationController)
        let viewModel = EscreverDiarioViewModel(coordinator: coordinator, registro: registro)
        let escreverDiarioViewController = EscreverDiarioViewController(viewModel: viewModel)

        escreverDiarioViewController.navigationController?.title = ""
        escreverDiarioViewController.navigationController?.navigationBar.prefersLargeTitles = false
        escreverDiarioViewController.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.currentNavigationController.pushViewController(escreverDiarioViewController, animated: true)
    }
    func dismiss() {
        navigationController.dismiss(animated: true, completion: {
            let firstViewController = self.navigationController.viewControllers.first
            guard let registrosViewController =  firstViewController as? RegistrosViewController else { return }
            registrosViewController.viewModel.loadRegistros()
            self.navigationController.popViewController(animated: true)
        })
    }
}
