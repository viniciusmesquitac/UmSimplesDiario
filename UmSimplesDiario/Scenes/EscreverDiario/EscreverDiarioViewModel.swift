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
    var coordinator: RegistrosCoordinator
    var disposeBag = DisposeBag()
    
    var inputs: EscreverDiarioViewModelInput { return self }
    var outputs: EscreverDiarioViewModelOutput { return self }
    
    
    init(coordinator: RegistrosCoordinator) {
        self.coordinator = coordinator
        
        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
    }
    
    func loadClima() {
        
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
