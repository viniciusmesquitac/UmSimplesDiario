//
//  EscreverDiarioViewModel+Protocol.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 07/05/21.
//

import RxCocoa
import RxSwift
import RxDataSources

protocol EscreverDiarioViewModelInput {
    var cancelButton: PublishSubject<Void> { get }
    var saveButton: PublishSubject<Void> { get }
    var humorButton: PublishSubject<Void> { get }
    var weatherButton: PublishSubject<Void> { get }
    var weather: BehaviorRelay<WeatherKeyResult> { get }
    var changeHumor: BehaviorRelay<Bool?> { get }
    var titleText: BehaviorRelay<String?> { get }
    var bodyText: BehaviorRelay<String?> { get }
    var itemsDataSourceRelay: BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]> { get }
}

protocol EscreverDiarioViewModelOutput {
    var titleTextOutput: Observable<String?> { get }
    var bodyTextOutput: Observable<String?> { get }
    var changeWeather: Observable<WeatherKeyResult> { get }
    var dataSourceOutput: Driver<[String?]> { get }
    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> { get }
    func loadClima()
}

protocol EscreverDiarioViewModelProtocol: ViewModel {
    var inputs: EscreverDiarioViewModelInput { get }
    var outputs: EscreverDiarioViewModelOutput { get }
}
