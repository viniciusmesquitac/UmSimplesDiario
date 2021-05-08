//
//  RegistrosViewModel+Protocols.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 07/05/21.
//

import RxSwift
import RxCocoa
import RxDataSources

protocol RegistrosViewModelInput {
    var selectedItem: BehaviorRelay<IndexPath?> { get }
    var deletedItem: BehaviorRelay<IndexPath?> { get }
    var composeButton: PublishSubject<Void> { get }
    var configButton: PublishSubject<Void> { get }
    var searchButton: PublishSubject<Void> { get }
    var listaRegistrosRelay: BehaviorRelay<[Registro]> { get }
    var itemsDataSourceRelay: BehaviorRelay<[SectionModel<String, Registro>]> { get }
}

protocol RegistrosViewModelOutput {
    var registrosObservable: Observable<[Registro]> { get }
    var registrosOutput: Observable<[Registro]> { get }
    var itemsDataSource: Observable<[SectionModel<String, Registro>]> { get }
    func loadRegistros()
}

protocol RegistrosViewModelProtocol: ViewModel {
    var inputs: RegistrosViewModelInput { get }
    var outputs: RegistrosViewModelOutput { get }
}
