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
    var titleText = BehaviorRelay<String?>(value: nil)
    var bodyText = BehaviorRelay<String?>(value: nil)
    
    var cancelButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()
    var coordinator: RegistrosCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()
    var registro: Registro?
    
    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    
    
    init(coordinator: RegistrosCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro
        
        if registro == nil {
            self.loadClima()
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
    }
    
    func loadClima() {
        let resource = Resource<WeatherResult>(url: WeatherAPI.weatherCity(name: "Fortaleza", stateCode: nil, countryCode: nil).url!)
        
//        URLRequest.load(resource: resource).subscribe(onNext: { result in
//            let weather = result?.weather
//            print(weather)
//        }).disposed(by: disposeBag)
    }
    
    func criarRegistro() {
        let registro = RegistroDTO(titulo: self.titleText.value,
                                   texto: self.bodyText.value,
                                   humor: .feliz,
                                   clima: .chuvoso)
        
        _ = repository.add(object: registro)
    }
    
    func salvarRegistro() {
        self.registro?.titulo = self.titleText.value
        self.registro?.texto = self.bodyText.value
        _ = repository.service.save()
    }
    
    func loadRegistro(registro: Registro) {
        self.bodyText.accept(registro.texto)
        self.titleText.accept(registro.titulo)
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
