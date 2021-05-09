//
//  ThemeViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import RxSwift
import RxCocoa

class ThemeViewModel: ThemeViewModelProtocol, ThemeViewModelInput, ThemeViewModelOutput {
    var deleteButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()

    var inputs: ThemeViewModelInput { return self }
    var outputs: ThemeViewModelOutput { return self }

    var coordinator: ConfigCoordinator
    let repository = RegistroRepository()

    let disposeBag = DisposeBag()

    init(coordinator: ConfigCoordinator) {
        self.coordinator = coordinator

        deleteButton.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        saveButton.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)
    }
}
