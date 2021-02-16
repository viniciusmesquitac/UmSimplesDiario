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
        mainView.searchBar.becomeFirstResponder()
        
        mainView.setupView()
        mainView.tableView.register(RegistrosViewCell.self, forCellReuseIdentifier: RegistrosViewCell.identifier)
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
        viewModel.outputs.registrosOutput.asObservable()
            .bind(to: mainView.tableView.rx
                    .items(cellIdentifier: RegistrosViewCell.identifier,
                           cellType: RegistrosViewCell.self)) { row, element, cell in
                cell.configure(RegistroModel(registro: element))
            }.disposed(by: disposeBag)
        
        
    }
    
    private func setupInputs() {
        mainView.tableView.rx.itemSelected.bind(to: viewModel.inputs.selectedItem).disposed(by: disposeBag)
        mainView.searchBar.rx.cancelButtonClicked.bind(to: viewModel.cancelButton).disposed(by: self.disposeBag)
        mainView.searchBar.rx.text.changed.bind(to: viewModel.searchBarText).disposed(by: self.disposeBag)
    }
}

class ResultadoPesquisaSearchController: UISearchController {
    
}


