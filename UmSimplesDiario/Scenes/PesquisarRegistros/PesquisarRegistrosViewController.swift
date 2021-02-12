//
//  PesquisarRegistrosViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit
import RxSwift

class PesquisarRegistrosViewController: UIViewController {
    
    let mainView = PesquisarRegistrosView()
    var viewModel: PesquisarRegistrosViewModel!
    let disposeBag = DisposeBag()
    
    init(viewModel: PesquisarRegistrosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = mainView.searchBar
        
        mainView.setupView()
        self.view = mainView
        setup()
    }
}

extension PesquisarRegistrosViewController {
    func setup() {
        setupInputs()
        setupOutputs()
    }
    
    
    private func setupOutputs() {
    }
    
    private func setupInputs() {
        mainView.searchBar.rx.cancelButtonClicked.bind(to: viewModel.cancelButton).disposed(by: self.disposeBag)
    }
}


