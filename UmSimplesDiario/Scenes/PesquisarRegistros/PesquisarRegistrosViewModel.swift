//
//  PesquisarRegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 11/02/21.
//

import RxCocoa
import RxSwift

protocol PesquisarRegistrosViewModelInput {
    var cancelButton: PublishSubject<Void> { get }
}

protocol PesquisarRegistrosViewModelOutput {
    
}

protocol PesquisarRegistrosViewModelProtocol: ViewModel {
    var inputs: PesquisarRegistrosViewModelInput { get }
    var outputs: PesquisarRegistrosViewModelOutput { get }
}

class PesquisarRegistrosViewModel: PesquisarRegistrosViewModelProtocol, PesquisarRegistrosViewModelInput {
    var cancelButton = PublishSubject<Void>()
    
    var inputs: PesquisarRegistrosViewModelInput { return self }
    var outputs: PesquisarRegistrosViewModelOutput { return self }
    
    var coordinator: RegistrosCoordinator?
    let disposeBag = DisposeBag()
    
    init(coordinator: RegistrosCoordinator) {
        self.coordinator = coordinator
        
        cancelButton.subscribe(onNext: {
            coordinator.dismiss()
        }).disposed(by: disposeBag)
    }
}

extension PesquisarRegistrosViewModel: PesquisarRegistrosViewModelOutput {
    
}

