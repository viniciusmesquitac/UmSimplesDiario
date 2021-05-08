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
    var headerTitle = [String]()

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
        viewModel.loadRegistros()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Registros"
        self.navigationItem.leftBarButtonItem = mainView.settingsButton
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

        // Create datasource
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Registro>>(
            configureCell: { _, table, _, item in
            return self.viewModel.makeCell(element: item, from: table)
        })
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        dataSource.canEditRowAtIndexPath = {_, _ in true }

        // Bind viewModel and dataSource
        viewModel.itemsDataSource
            .bind(to: mainView.tableView.rx.items(dataSource: dataSource))
          .disposed(by: disposeBag)

        // Empty State
        viewModel.outputs.itemsDataSource.subscribe(onNext: { registros in
            self.mainView.emptyState(registros.isEmpty)
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
        return 32
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        view.backgroundView = UIView()
        return view
    }
}
