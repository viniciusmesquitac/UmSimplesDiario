//
//  RegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import RxSwift
import RxCocoa

protocol RegistrosViewModelInput {
    var selectedItem: BehaviorRelay<IndexPath?> { get }
    var composeButton: PublishSubject<Void> { get }
    var searchButton: PublishSubject<Void> { get }
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
    var searchButton = PublishSubject<Void>()
    
    var composeButton = PublishSubject<Void>()
    
    var selectedItem = BehaviorRelay<IndexPath?>(value: nil)
    
    var coordinator: RegistrosCoordinator
    var disposeBag = DisposeBag()
    
    var inputs: RegistrosViewModelInput { return self }
    var outputs: RegistrosViewModelOutput { return self }
    
    var listaRegistrosRelay = BehaviorRelay<[Registro]>(value: [])
    var registros: [Registro]
    
    init(coordinator: RegistrosCoordinator, registros: [Registro]) {
        self.coordinator = coordinator
        self.registros = registros
        
        loadRegistros()
        
        selectedItem.subscribe { indexPath in
            guard let row = indexPath.element??.row else { return }
            print(registros[row])
            
        }.disposed(by: disposeBag)
        
        composeButton.subscribe(onNext: { _ in
            print("tap composeButton")
        }).disposed(by: disposeBag)
        
        searchButton.subscribe(onNext: { _ in
            print("tap searchButton")
        }).disposed(by: disposeBag)

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
