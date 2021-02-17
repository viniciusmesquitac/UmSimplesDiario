//
//  EscreverDiarioViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import RxCocoa
import RxSwift

protocol EscreverDiarioViewModelInput {
    var cancelButton: PublishSubject<Void> { get }
    var saveButton: PublishSubject<Void> { get }
    var humorButton: PublishSubject<Void> { get }
    var weatherButton: PublishSubject<Void> { get }
    var weather: BehaviorRelay<Clima> { get }
    var changeHumor: BehaviorRelay<Bool?> { get }
    var titleText: BehaviorRelay<String?> { get }
    var bodyText: BehaviorRelay<String?> { get }

}

protocol EscreverDiarioViewModelOutput {
    var titleTextOutput: Observable<String?> { get }
    var bodyTextOutput: Observable<String?> { get }
    var changeWeather: Observable<Clima> { get }
    var dataSourceOutput: Driver<[String?]> { get }
    func loadClima()
}

protocol EscreverDiarioViewModelProtocol: ViewModel {
    var inputs: EscreverDiarioViewModelInput { get }
    var outputs: EscreverDiarioViewModelOutput { get }
}

class EscreverDiarioViewModel: EscreverDiarioViewModelProtocol, EscreverDiarioViewModelInput {
    var weather =  BehaviorRelay<Clima>(value: .none)
    
    var changeHumor = BehaviorRelay<Bool?>(value: nil)
    var titleText = BehaviorRelay<String?>(value: nil)
    var bodyText = BehaviorRelay<String?>(value: nil)
    
    var cancelButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()
    var humorButton = PublishSubject<Void>()
    var weatherButton = PublishSubject<Void>()

    var coordinator: RegistrosCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()
    var registro: Registro?
    var clima: Clima = .none
    var humor: Humor = .none
    
    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    
    
    init(coordinator: RegistrosCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro
        
        if registro != nil {
            self.loadRegistro(registro: registro!)
        } else {
            self.titleText.accept("Sem titulo")
        }
        
        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        saveButton.subscribe(onNext: {
            if registro != nil {
                self.salvarRegistro()
            } else {
                self.criarRegistro()
            }
            coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        humorButton.subscribe(onNext: {
            if let humor = self.changeHumor.value {
                self.changeHumor.accept(!humor)
                self.humor = !humor ? .triste : .feliz
            } else {
                self.changeHumor.accept(false)
                self.humor = .feliz
            }
        }).disposed(by: disposeBag)
        
        weatherButton.subscribe(onNext: {
            self.loadClima()
        }).disposed(by: disposeBag)
    }
    
    func loadClima() {
        let resource = Resource<WeatherResult>(url: WeatherAPI.weatherCity(name: "Maracanau", stateCode: nil, countryCode: nil).url!)
        URLRequest.load(resource: resource).subscribe(onNext: { result in
            if let weather = result?.weather.first?.description {
                switch weather {
                case "clear sky":
                    self.clima = .ceuLimpo
                    self.weather.accept(self.clima)
                case "few clouds":
                    self.clima = .nuvens
                    self.weather.accept(self.clima)
                case "broken clouds":
                    self.clima = .nuvens
                    self.weather.accept(self.clima)
                case "scattered clouds":
                    self.clima = .nuvens
                    self.weather.accept(self.clima)
                case "rain":
                    self.clima = .chuva
                    self.weather.accept(self.clima)
                case "moderate rain":
                    self.clima = .chuva
                    self.weather.accept(self.clima)
                case "shower rain":
                    self.clima = .chuvaComSol
                    self.weather.accept(.chuvaComSol)
                case "thunderstorm":
                    self.clima = .tempestade
                    self.weather.accept(.tempestade)
                default:
                    self.clima = .ceuLimpo
                    self.weather.accept(.ceuLimpo)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func criarRegistro() {
        var title = self.titleText.value
        if title == "" { title = "Sem titulo" }
        let registro = RegistroDTO(titulo: title,
                                   texto: self.bodyText.value,
                                   humor: humor,
                                   clima: clima)
        
        _ = repository.add(object: registro)
    }
    
    func salvarRegistro() {
        if self.titleText.value == "" {
            self.registro?.titulo = "Sem titulo"
        } else {
            self.registro?.titulo = self.titleText.value
        }
        self.registro?.texto = self.bodyText.value
        self.registro?.humor = self.humor.rawValue
        self.registro?.clima = self.clima.rawValue
        _ = repository.service.save()
    }
    
    func loadRegistro(registro: Registro) {
        switch registro.humor {
        case 0: self.changeHumor.accept(false)
        case 1: self.changeHumor.accept(true)
        case 2: self.changeHumor.accept(true)
        default: self.changeHumor.accept(true)
        }
        self.humor = Humor.allCases[Int(registro.humor)]
        self.bodyText.accept(registro.texto)
        self.titleText.accept(registro.titulo)
//        self.changeHumor.accept(registro.humor == 0 ? false : true)
        self.weather.accept(Clima.allCases[Int(registro.clima)])
        self.clima = Clima.allCases[Int(registro.clima)]

    }
}

extension EscreverDiarioViewModel: EscreverDiarioViewModelOutput {
    
    var changeWeather: Observable<Clima> {
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
    
}
