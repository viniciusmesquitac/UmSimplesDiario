//
//  RegistrosViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

import RxSwift
import RxCocoa

class RegistrosViewController: UIViewController {

    let mainView = RegistrosView()
    var viewModel: RegistrosViewModel!
    let disposeBag = DisposeBag()
    

    init(viewModel: RegistrosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Registros"
        let button1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        self.navigationItem.rightBarButtonItems  = [button1, button1]
        
        mainView.setupView()
        mainView.tableView.register(RegistrosViewCell.self, forCellReuseIdentifier: RegistrosViewCell.identifier)
        self.view = mainView
        setup()
    }
    
}

extension RegistrosViewController {
    
    func setup() {
        setupInputs()
        setupOutputs()
    }
    
    private func setupOutputs() { }
    
    private func setupInputs() {
        viewModel.inputs.listaRegistrosRelay.asObservable()
            .bind(to: mainView.tableView.rx
                    .items(cellIdentifier: RegistrosViewCell.identifier,
                           cellType: RegistrosViewCell.self)) { row, element, cell in
                cell.configure(element)
            }.disposed(by: disposeBag)
    }
    
}
