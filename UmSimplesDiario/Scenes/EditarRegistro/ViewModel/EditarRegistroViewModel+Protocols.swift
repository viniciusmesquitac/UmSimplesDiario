//
//  EditarRegistroViewModel+Protocols.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 06/05/21.
//

import RxSwift
import RxCocoa
import RxDataSources

protocol EditarRegistroViewModelInput {
    var moreButton: PublishSubject<Void> { get }
    var humorButton: PublishSubject<Void> { get }
    var weatherButton: PublishSubject<Void> { get }
    var weather: BehaviorRelay<WeatherKeyResult> { get }
    var changeHumor: BehaviorRelay<Bool?> { get }
    var titleText: BehaviorRelay<String?> { get }
    var bodyText: BehaviorRelay<String?> { get }
    var itemsDataSourceRelay: BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]> { get }
}

protocol EditarRegistroViewModelOutput {
    var titleTextOutput: Observable<String?> { get }
    var bodyTextOutput: Observable<String?> { get }
    var changeWeather: Observable<WeatherKeyResult> { get }
    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> { get }
    func loadClima()
}

protocol EditarRegistroViewModelProtocol: ViewModel {
    var inputs: EditarRegistroViewModelInput { get }
    var outputs: EditarRegistroViewModelOutput { get }
}

extension EditarRegistroViewModel: EditarRegistroViewModelOutput {
    func loadClima() { }
    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> {
        self.inputs.itemsDataSourceRelay.asObservable()
    }
    var changeWeather: Observable<WeatherKeyResult> {
        self.inputs.weather.asObservable()
    }

    var titleTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

    var bodyTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

}
