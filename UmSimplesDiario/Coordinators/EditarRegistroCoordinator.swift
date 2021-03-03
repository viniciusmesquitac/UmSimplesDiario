//
//  EditarRegistroCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit

final class EditarRegistroCoordinator: Coordinator {
    func start() { }
    var navigationController: UINavigationController!
    var currentViewController: UIViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(registro: Registro) {
        let viewModel = EditarRegistroViewModel(coordinator: self, registro: registro)
        let editarRegistoViewController = EditarRegistroViewController(viewModel: viewModel)
        currentViewController = editarRegistoViewController
        editarRegistoViewController.navigationController?.title = registro.titulo
        editarRegistoViewController.navigationController?.navigationBar.prefersLargeTitles = false
        editarRegistoViewController.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController.pushViewController(editarRegistoViewController, animated: true)
    }
    
    func showConfigure() {
        let configurarRegistroViewController = ConfigurarRegistroViewController()
        self.currentViewController.addChild(configurarRegistroViewController)
        self.currentViewController.view.addSubview(configurarRegistroViewController.view)
        configurarRegistroViewController.didMove(toParent: currentViewController)
        let height = currentViewController.view.frame.height
        let width  = currentViewController.view.frame.width
        configurarRegistroViewController.view.frame = CGRect(x: 0, y: currentViewController.view.frame.maxY, width: width, height: height)
        
        print("Configure")
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
