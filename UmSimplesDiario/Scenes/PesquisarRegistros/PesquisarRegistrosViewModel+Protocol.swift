//
//  PesquisarRegistrosViewModel+Protocol.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 07/05/21.
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
