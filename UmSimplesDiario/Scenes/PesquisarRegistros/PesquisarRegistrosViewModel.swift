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
    var selectedItem: BehaviorRelay<IndexPath?> { get }
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
    internal var searchBarText = BehaviorRelay<String?>(value: nil)
    
    internal var listaRegistrosRelay = BehaviorRelay<[Registro]>(value: [])

    internal var selectedItem = BehaviorRelay<IndexPath?>(value: nil)
    
    internal var cancelButton = PublishSubject<Void>()

    public var inputs: PesquisarRegistrosViewModelInput { return self }
    public var outputs: PesquisarRegistrosViewModelOutput { return self }
    
    private var coordinator: PesquisarRegistrosCoordinator?
    private var registros: [Registro]!
    private let disposeBag = DisposeBag()

    init(coordinator: PesquisarRegistrosCoordinator, registros: [Registro]) {
        self.coordinator = coordinator
        self.registros = registros

        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        searchBarText.subscribe(onNext: { text in
            guard let text = text else { return }
            let filtered = registros.filter { $0.titulo?.contains(text) ?? false || $0.texto?.contains(text) ?? false }
            self.registros = filtered
            self.inputs.listaRegistrosRelay.accept(filtered)
        }).disposed(by: disposeBag)
        
        selectedItem.subscribe { indexPath in
            guard let row = indexPath.element??.row else { return }
            coordinator.editCompose(registro: self.registros[row])
            print(self.registros[row])
        }.disposed(by: disposeBag)
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
