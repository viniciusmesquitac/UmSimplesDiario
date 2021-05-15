//
//  File.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import RxSwift

protocol ThemeViewModelInput {
    var deleteButton: PublishSubject<Void> { get }
}

protocol ThemeViewModelOutput { }

protocol ThemeViewModelProtocol: ViewModel {
    var inputs: ThemeViewModelInput { get }
    var outputs: ThemeViewModelOutput { get }
}
