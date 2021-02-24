//
//  RegistrosViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

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
        self.navigationItem.rightBarButtonItems = [mainView.composeButton, mainView.searchButton]

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

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Registro>>(
            configureCell: { _, table, _, item in
            return self.viewModel.makeCell(element: item, from: table)
        })
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        dataSource.canEditRowAtIndexPath = {_, _ in true }

        viewModel.itemsDataSource
            .bind(to: mainView.tableView.rx.items(dataSource: dataSource))
          .disposed(by: disposeBag)
        viewModel.outputs.itemsDataSource.subscribe(onNext: { registros in
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
        mainView.tableView.rx.itemDeleted.bind(to: viewModel.deletedItem).disposed(by: disposeBag)
    }
}

extension RegistrosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionRegistrosHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 80)))
        header.setupView()
        header.titleLabel.text = SectionCell.allCases[section + 1].sectionTitle
        return header
    }
}
