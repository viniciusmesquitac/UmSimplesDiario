//
//  ConfigurarRegistrosViewModel+Protocol.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 07/05/21.
//

import RxCocoa
import RxSwift

protocol ConfigurarRegistroViewModelInput {
    var deleteButton: PublishSubject<Void> { get }
}

protocol ConfigurarRegistroViewModelOutput { }

protocol ConfigurarRegistroViewModelProtocol: ViewModel {
    var inputs: ConfigurarRegistroViewModelInput { get }
    var outputs: ConfigurarRegistroViewModelOutput { get }
}
