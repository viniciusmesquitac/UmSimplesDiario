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
    var changeHumor: BehaviorRelay<Bool> { get }
    var titleText: BehaviorRelay<String?> { get }
    var bodyText: BehaviorRelay<String?> { get }
}

protocol EscreverDiarioViewModelOutput {
    var titleTextOutput: Observable<String?> { get }
    var bodyTextOutput: Observable<String?> { get }
    var dataSourceOutput: Driver<[String?]> { get }
    func loadClima()
}

protocol EscreverDiarioViewModelProtocol: ViewModel {
    var inputs: EscreverDiarioViewModelInput { get }
    var outputs: EscreverDiarioViewModelOutput { get }
}

class EscreverDiarioViewModel: EscreverDiarioViewModelProtocol, EscreverDiarioViewModelInput {
    var changeHumor = BehaviorRelay<Bool>(value: false)
    var titleText = BehaviorRelay<String?>(value: nil)
    var bodyText = BehaviorRelay<String?>(value: nil)
    
    var cancelButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()
    var humorButton = PublishSubject<Void>()

    var coordinator: RegistrosCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()
    var registro: Registro?
    var clima: Clima = .ceuLimpo
    var humor: Humor = .feliz
    
    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    
    
    init(coordinator: RegistrosCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro
        
        let ideas = ["Como foi o meu dia hoje?",
                     "Qual a minha maior frustração?",
                     "O que me faz feliz?", "Qual problema eu consegui resolver?"]
        
        if registro == nil {
            self.loadClima()
            self.titleText.accept("Sem titulo")
        } else {
            self.loadRegistro(registro: registro!)
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
            self.changeHumor.accept(!self.changeHumor.value)
            self.humor = self.changeHumor.value ? .triste : .feliz
        }).disposed(by: disposeBag)
    }
    
    func loadClima() {
        let resource = Resource<WeatherResult>(url: WeatherAPI.weatherCity(name: "Maracanau", stateCode: nil, countryCode: nil).url!)
        URLRequest.load(resource: resource).subscribe(onNext: { result in
            if let weather = result?.weather.first?.description {
                switch weather {
                case "clear sky": self.clima = .ceuLimpo
                case "few clouds": self.clima = .nuvens
                case "broken clouds": self.clima = .nuvens
                case "scattered clouds": self.clima = .nuvens
                case "rain": self.clima = .chuva
                case "shower rain": self.clima = .chuvaComSol
                case "thunderstorm": self.clima = .tempestade
                default: self.clima = .nuvens
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
        _ = repository.service.save()
    }
    
    func loadRegistro(registro: Registro) {
        self.bodyText.accept(registro.texto)
        self.titleText.accept(registro.titulo)
        self.changeHumor.accept(registro.humor == 0 ? false : true)
    }
}

extension EscreverDiarioViewModel: EscreverDiarioViewModelOutput {
    
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
