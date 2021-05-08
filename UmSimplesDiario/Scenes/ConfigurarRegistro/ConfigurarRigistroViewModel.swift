//
//  ConfigurarRigistroViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 03/03/21.
//

import RxSwift
import RxCocoa

class ConfigurarRegistroViewModel: ConfigurarRegistroViewModelProtocol, ConfigurarRegistroViewModelInput {
    var deleteButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()

    var inputs: ConfigurarRegistroViewModelInput { return self }
    var outputs: ConfigurarRegistroViewModelOutput { return self }

    var coordinator: EditarRegistroCoordinator
    let repository = RegistroRepository()
    private var registro: Registro

    let disposeBag = DisposeBag()

    init(coordinator: EditarRegistroCoordinator, registro: Registro) {
        self.coordinator = coordinator
        self.registro = registro

        deleteButton.subscribe(onNext: { _ in
            self.showAlert()
        }).disposed(by: disposeBag)

        saveButton.subscribe(onNext: { _ in
            self.repository.save(object: registro)
            coordinator.dismissToRegistros()
        }).disposed(by: disposeBag)
    }
}

extension ConfigurarRegistroViewModel: ConfigurarRegistroViewModelOutput {
    func showAlert() {
        let alertController = UIAlertController(title: "Deseja deletar esse registro?",
                                                message: "Você irá deletar permanentemente este registro.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Deletar", style: .default) { _ in
            self.repository.delete(object: self.registro)
            self.coordinator.dismissToRegistros()
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
           print("cancelado")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.coordinator.navigationController.dismiss(animated: true, completion: {
            self.coordinator.navigationController.present(alertController, animated: true)
        })
    }
}
