//
//  RegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import RxSwift
import RxCocoa

protocol RegistrosViewModelInput {
    var listaRegistrosRelay: BehaviorRelay<[Registro]> { get }
}

protocol RegistrosViewModelOutput {
    var registrosOutput: Observable<[Registro]> { get }
    var registrosDriver: Driver<[Registro]> { get }
    func loadRegistros()
}

protocol RegistrosViewModelProtocol: ViewModel {
    var inputs: RegistrosViewModelInput { get }
    var outputs: RegistrosViewModelOutput { get }
}

class RegistrosViewModel: RegistrosViewModelProtocol, RegistrosViewModelInput {
    var coordinator: RegistrosCoordinator
    var disposeBag = DisposeBag()
    
    var inputs: RegistrosViewModelInput { return self }
    var outputs: RegistrosViewModelOutput { return self }
    
    var listaRegistrosRelay = BehaviorRelay<[Registro]>(value: [])
    // var registros: [RegistrosViewModel]
    var registros: [Registro]
    
    init(coordinator: RegistrosCoordinator, registros: [Registro]) {
        self.coordinator = coordinator
        self.registros = registros
        
        loadRegistros()
    }

    
    func loadRegistros() {
        outputs.registrosOutput.subscribe { value in
            self.inputs.listaRegistrosRelay.accept(value)
        }.disposed(by: disposeBag)
    }
}

// MARK: ViewModel Output

extension RegistrosViewModel: RegistrosViewModelOutput {
    
    var registrosOutput: Observable<[Registro]> {
        Observable.of(self.registros)
    }
    
    var registrosDriver: Driver<[Registro]> {
        self.inputs.listaRegistrosRelay.accept(self.registros)
        return Driver.just(self.registros)
    }
}
