//
//  EscreverDiarioViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import RxCocoa
import RxSwift
import RxDataSources

class EditarRegistroViewModel: EditarRegistroViewModelProtocol, EditarRegistroViewModelInput, WritableViewModel {
    var itemsDataSourceRelay = BehaviorRelay<[SectionModel<String, EditarRegistroCellModel>]>(value: [])

    var weather =  BehaviorRelay<WeatherKeyResult>(value: .none)
    var changeHumor = BehaviorRelay<Bool?>(value: nil)
    var titleText = BehaviorRelay<String?>(value: nil)
    var bodyText = BehaviorRelay<String?>(value: nil)

    var humorButton = PublishSubject<Void>()
    var moreButton = PublishSubject<Void>()
    var weatherButton = PublishSubject<Void>()

    var coordinator: EditarRegistroCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()
    var registro: Registro?
    var clima: WeatherKeyResult = .none
    var humor: Humor = .none

    var heightBody = CGFloat(120)
    var heightTitle = CGFloat(120)

    var inputs: EditarRegistroViewModelInput { return self }
    var outputs: EditarRegistroViewModelOutput { return self }

    init(coordinator: EditarRegistroCoordinator, registro: Registro?) {
        self.coordinator = coordinator
        self.registro = registro
        loadRegistro(registro: self.registro!)

        moreButton.subscribe(onNext: {
            coordinator.showConfigure(registro: self.registro!)
        }).disposed(by: disposeBag)

        titleText.subscribe(onNext: { _ in
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
        self.registro?.clima = self.clima.index
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
        self.weather.accept(WeatherKeyResult.allCases[Int(registro.clima)])
        self.clima = WeatherKeyResult.allCases[Int(registro.clima)]
    }
}
