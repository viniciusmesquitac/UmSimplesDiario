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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Registros"
        self.navigationItem.rightBarButtonItems = [mainView.composeButton]
        
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
    
    private func setupOutputs() {
        viewModel.outputs.registrosOutput.asObservable()
            .bind(to: mainView.tableView.rx
                    .items(cellIdentifier: RegistrosViewCell.identifier,
                           cellType: RegistrosViewCell.self)) { row, element, cell in
                cell.configure(RegistroModel(registro: element))
            }.disposed(by: disposeBag)
        
        viewModel.outputs.registrosOutput.subscribe(onNext: { registros in
            if registros.isEmpty {
                self.mainView.emptyStateLabel.isHidden = false
                self.mainView.tableView.isScrollEnabled = false
            } else {
                self.mainView.emptyStateLabel.isHidden = true
                self.mainView.tableView.isScrollEnabled = true
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func setupInputs() {
        mainView.tableView.rx.itemSelected.bind(to: viewModel.inputs.selectedItem).disposed(by: disposeBag)
        mainView.composeButton.rx.tap.bind(to: viewModel.inputs.composeButton).disposed(by: disposeBag)
        mainView.searchButton.rx.tap.bind(to: viewModel.inputs.searchButton).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension RegistrosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
    }
}
