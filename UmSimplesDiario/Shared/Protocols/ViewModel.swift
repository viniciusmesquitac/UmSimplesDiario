//
//  ViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

protocol ViewModel { }

protocol WritableViewModel {
    var heightTitle: CGFloat { get set }
}

protocol StaticViewModel: ViewModel {
    var sections: [ConfigSection] { get set }
}
