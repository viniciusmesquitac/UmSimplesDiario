//
//  PesquisarRegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 11/02/21.
//

import RxCocoa
import RxSwift

protocol PesquisarRegistrosViewModelInput {
    var cancelButton: PublishSubject<Void> { get }
    var searchBarText: BehaviorRelay<String?> { get }
    var listaRegistrosRelay: BehaviorRelay<[Registro]> { get }
}

protocol PesquisarRegistrosViewModelOutput {
    var registrosObservable: Observable<[Registro]> { get }
    var registrosOutput: Observable<[Registro]> { get }
}

protocol PesquisarRegistrosViewModelProtocol: ViewModel {
    var inputs: PesquisarRegistrosViewModelInput { get }
    var outputs: PesquisarRegistrosViewModelOutput { get }
}

class PesquisarRegistrosViewModel: PesquisarRegistrosViewModelProtocol, PesquisarRegistrosViewModelInput {
    var searchBarText = BehaviorRelay<String?>(value: nil)
    
    var listaRegistrosRelay = BehaviorRelay<[Registro]>(value: [])
    
    var cancelButton = PublishSubject<Void>()
    
    var inputs: PesquisarRegistrosViewModelInput { return self }
    var outputs: PesquisarRegistrosViewModelOutput { return self }
    
    var coordinator: RegistrosCoordinator?
    var registros: [Registro]!
    let disposeBag = DisposeBag()
    
    init(coordinator: RegistrosCoordinator, registros: [Registro]) {
        self.coordinator = coordinator
        self.registros = registros
        
        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        
        searchBarText.subscribe(onNext: { text in
            guard let text = text else { return }
            let filtered = registros.filter { $0.titulo?.contains(text) ?? false || $0.texto?.contains(text) ?? false }
            self.inputs.listaRegistrosRelay.accept(filtered)
        }).disposed(by: disposeBag)
    }
}

extension PesquisarRegistrosViewModel: PesquisarRegistrosViewModelOutput {
    
    var registrosObservable: Observable<[Registro]> {
        Observable.of(self.registros)
    }
    
    var registrosOutput: Observable<[Registro]> {
        self.inputs.listaRegistrosRelay.asObservable()
    }
}

