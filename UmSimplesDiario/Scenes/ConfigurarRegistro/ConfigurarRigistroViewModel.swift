//
//  ConfigurarRigistroViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 03/03/21.
//

import RxSwift

protocol ConfigurarRegistroViewModelInput {
    var deleteButton: PublishSubject<Void> { get }
}

protocol ConfigurarRegistroViewModelOutput {
    
}

protocol ConfigurarRegistroViewModelProtocol: ViewModel {
    var inputs: ConfigurarRegistroViewModelInput { get }
    var outputs: ConfigurarRegistroViewModelOutput { get }
}

class ConfigurarRegistroViewModel: ConfigurarRegistroViewModelProtocol, ConfigurarRegistroViewModelInput {
    var deleteButton = PublishSubject<Void>()
    
    var inputs: ConfigurarRegistroViewModelInput { return self }
    var outputs: ConfigurarRegistroViewModelOutput { return self }
    
    var coordinator: EditarRegistroCoordinator
    let repository = RegistroRepository()

    init(coordinator: EditarRegistroCoordinator,registro: Registro) {
        self.coordinator = coordinator

        deleteButton.subscribe { _ in
            self.repository.delete(object: registro)
            coordinator.dismissToRegistros()
        }
    }
    
}

extension ConfigurarRegistroViewModel: ConfigurarRegistroViewModelOutput {
}
