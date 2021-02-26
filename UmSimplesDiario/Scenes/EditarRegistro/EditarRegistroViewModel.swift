//
//  EscreverDiarioViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import RxCocoa
import RxSwift
import RxDataSources

protocol EditarRegistroViewModelInput {
    var cancelButton: PublishSubject<Void> { get }
    var saveButton: PublishSubject<Void> { get }
    var humorButton: PublishSubject<Void> { get }
    var weatherButton: PublishSubject<Void> { get }
    var weather: BehaviorRelay<Clima> { get }
    var changeHumor: BehaviorRelay<Bool?> { get }
    var titleText: BehaviorRelay<String?> { get }
    var bodyText: BehaviorRelay<String?> { get }
    var itemsDataSourceRelay: BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]> { get }
}

protocol EditarRegistroViewModelOutput {
    var titleTextOutput: Observable<String?> { get }
    var bodyTextOutput: Observable<String?> { get }
    var changeWeather: Observable<Clima> { get }
    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> { get }
    func loadClima()
}

protocol EditarRegistroViewModelProtocol: ViewModel {
    var inputs: EditarRegistroViewModelInput { get }
    var outputs: EditarRegistroViewModelOutput { get }
}

class EditarRegistroViewModel: EditarRegistroViewModelProtocol, EditarRegistroViewModelInput {

    var itemsDataSourceRelay = BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]>(value: [])

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

    var heightBody = CGFloat(120)
    var heightTitle = CGFloat(120)

    var inputs: EditarRegistroViewModelInput { return self }
    var outputs: EditarRegistroViewModelOutput { return self }

    init(coordinator: RegistrosCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro
        loadRegistro(registro: self.registro!)

        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)

        titleText.subscribe(onNext: { text in
            self.salvarRegistro()
        }).disposed(by: self.disposeBag)

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
        let texto = EditarRegistroCellModel.texto(registro.texto ?? "")
        let titulo =  EditarRegistroCellModel.titulo(registro.titulo ?? "")
        self.itemsDataSourceRelay
            .accept([SectionModel(model: "",
                                  items: [titulo, texto]
            )])

        switch registro.humor {
        case 0: self.changeHumor.accept(false)
        case 1: self.changeHumor.accept(true)
        case 2: self.changeHumor.accept(nil)
        default: self.changeHumor.accept(nil)
        }
        self.humor = Humor.allCases[Int(registro.humor)]
        self.bodyText.accept(registro.texto)
        self.titleText.accept(registro.titulo)
        self.weather.accept(Clima.allCases[Int(registro.clima)])
        self.clima = Clima.allCases[Int(registro.clima)]
    }
}

extension EditarRegistroViewModel: EditarRegistroViewModelOutput {
    func loadClima() { }
    var itemsDataSource: Observable<[SectionModel<String, EditarRegistroCellModel>]> {
        self.inputs.itemsDataSourceRelay.asObservable()

    }
    var changeWeather: Observable<Clima> {
        self.inputs.weather.asObservable()
    }

    var titleTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

    var bodyTextOutput: Observable<String?> {
        self.inputs.bodyText.asObservable()
    }

}
