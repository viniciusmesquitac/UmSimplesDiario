//
//  EscreverDiarioViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import RxCocoa
import RxSwift
import RxDataSources
import MapKit
import CoreLocation

class EscreverDiarioViewModel: EscreverDiarioViewModelProtocol, EscreverDiarioViewModelInput {
    var weather =  BehaviorRelay<WeatherKeyResult>(value: .none)

    var changeHumor = BehaviorRelay<Bool?>(value: nil)
    var titleText = BehaviorRelay<String?>(value: nil)
    var bodyText = BehaviorRelay<String?>(value: nil)

    var cancelButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()
    var humorButton = PublishSubject<Void>()
    var imageButton = PublishSubject<Void>()
    var weatherButton = PublishSubject<Void>()

    var coordinator: RegistrosCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()
    var registro: Registro?
    var clima: WeatherKeyResult = .none
    var humor: Mood = .none

    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    var itemsDataSourceRelay = BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]>(value: [])

    var heightBody = CGFloat(120)
    var heightTitle = CGFloat(120)

    let locationManager = CLLocationManager()

    init(coordinator: RegistrosCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro

        loadRegistro()

        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)

        saveButton.subscribe(onNext: {
            self.criarRegistro()
            coordinator.dismiss()
        }).disposed(by: disposeBag)

        humorButton.subscribe(onNext: {
            if let humor = self.changeHumor.value {
                self.changeHumor.accept(!humor)
                self.humor = !humor ? .sad : .happy
            } else {
                self.changeHumor.accept(false)
                self.humor = .happy
            }
        }).disposed(by: disposeBag)

        weatherButton.subscribe(onNext: {
            self.askForLocationAuth()
        }).disposed(by: disposeBag)
    }

    func loadRegistro() {
        let titulo =  EditarRegistroCellModel.titulo("Sem titulo")
        let texto = EditarRegistroCellModel.texto( "")
        self.itemsDataSourceRelay
            .accept([SectionModel(model: "",
                                  items: [titulo, texto]
            )])
    }

    func askForLocationAuth() {
        locationManager.requestWhenInUseAuthorization()
    }

    func loadClima(cityName: String) {
        let resource = Resource<WeatherResult>(
            url: WeatherAPI.weatherCity(name: cityName).url!)
        URLRequest.load(resource: resource).subscribe(onNext: { result in
            if let result = result?.weather.first?.description,
               let key = WeatherKeyResult.allCases.filter({ $0.rawValue == result })
                .first {
                    self.weather.accept(key)
            }
        }).disposed(by: disposeBag)
    }

    func criarRegistro() {
        var title = self.titleText.value
        let text = self.bodyText.value
        let weather = self.weather.value
        if title == "" || title == nil { title = "Sem titulo" }
        let registro = RegistroDTO(title: title,
                                   text: text,
                                   mood: humor,
                                   weather: weather)
        repository.add(object: registro)
    }
}

extension EscreverDiarioViewModel: EscreverDiarioViewModelOutput {

    var changeWeather: Observable<WeatherKeyResult> {
        self.inputs.weather.asObservable()
    }

    var titleTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

    var bodyTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

    var dataSourceOutput: Driver<[String?]> {
        Driver.just([titleText.value, bodyText.value])
    }

    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> {
        self.inputs.itemsDataSourceRelay.asObservable()
    }

}
