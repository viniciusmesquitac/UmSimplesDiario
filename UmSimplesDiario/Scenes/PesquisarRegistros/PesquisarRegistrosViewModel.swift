//
//  PesquisarRegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 11/02/21.
//

import Foundation

protocol PesquisarRegistrosViewModelInput {
}

protocol PesquisarRegistrosViewModelOutput {
    
}

protocol PesquisarRegistrosViewModelProtocol: ViewModel {
    var inputs: PesquisarRegistrosViewModelInput { get }
    var outputs: PesquisarRegistrosViewModelOutput { get }
}

class PesquisarRegistrosViewModel: PesquisarRegistrosViewModelProtocol, PesquisarRegistrosViewModelInput {
    
    var inputs: PesquisarRegistrosViewModelInput { return self }
    var outputs: PesquisarRegistrosViewModelOutput { return self }
    
    var coordinator: RegistrosCoordinator?
    
    init(coordinator: RegistrosCoordinator) {
        self.coordinator = coordinator
        
    }
}

extension PesquisarRegistrosViewModel: PesquisarRegistrosViewModelOutput {
    
}

