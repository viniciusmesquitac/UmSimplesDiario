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

    let disposeBag = DisposeBag()

    init(coordinator: EditarRegistroCoordinator, registro: Registro) {
        self.coordinator = coordinator

        deleteButton.subscribe(onNext: { _ in
            self.repository.delete(object: registro)
            coordinator.dismissToRegistros()
        }).disposed(by: disposeBag)

        saveButton.subscribe(onNext: { _ in
            self.repository.save(object: registro)
            coordinator.dismissToRegistros()
        }).disposed(by: disposeBag)
    }
}

extension ConfigurarRegistroViewModel: ConfigurarRegistroViewModelOutput {
}
