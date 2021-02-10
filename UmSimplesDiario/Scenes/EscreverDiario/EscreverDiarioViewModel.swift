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
    var disposeBag = DisposeBag()
    
    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    
    
    init(coordinator: RegistrosCoordinator) {
        self.coordinator = coordinator
        
        loadClima()
        
        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        saveButton.subscribe(onNext: {
            self.criarRegistro()
            coordinator.dismiss()
        }).disposed(by: disposeBag)
    }
    
    func loadClima() {
        let resource = Resource<WeatherResult>(url: WeatherAPI.weatherCity(name: "Fortaleza", stateCode: nil, countryCode: nil).url!)
        
        URLRequest.load(resource: resource).subscribe(onNext: { result in
            let weather = result?.weather
            print(weather)
        }).disposed(by: disposeBag)
    }
    
    func criarRegistro() {
        print(Registro(titulo: titleText.value, descricao: "Apenas um diario", texto: bodyText.value))
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
