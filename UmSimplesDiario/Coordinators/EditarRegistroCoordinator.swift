//
//  EditarRegistroCoordinator.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit

final class EditarRegistroCoordinator: NSObject, Coordinator {
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

    func showConfigure(registro: Registro) {
        let viewModel = ConfigurarRegistroViewModel(coordinator: self, registro: registro)
        let configurarRegistroViewController = ConfigurarRegistroViewController(viewModel: viewModel)
        configurarRegistroViewController.modalPresentationStyle = .custom
            configurarRegistroViewController.transitioningDelegate = self
            navigationController.present(configurarRegistroViewController, animated: true, completion: nil)
    }

    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func dismissToRegistros() {
        navigationController.dismiss(animated: true, completion: {
            self.navigationController.popViewController(animated: true)
        })
    }
}

extension EditarRegistroCoordinator: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
