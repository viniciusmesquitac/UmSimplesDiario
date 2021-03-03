//
//  EscreverDiarioViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit
import RxSwift
import RxDataSources

class EscreverDiarioViewController: UIViewController {

    let mainView = EscreverDiarioView()
    var viewModel: EscreverDiarioViewModel!
    let disposeBag = DisposeBag()

    var heightBody = CGFloat(0)
    var heightTitle = CGFloat(0)

    init(viewModel: EscreverDiarioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel.registro != nil {
            navigationItem.leftBarButtonItems = [mainView.navigationBackButtonItem, mainView.navigationBarButtonTitle]
        } else {
            navigationItem.leftBarButtonItem = mainView.navigationBarButtonTitle
        }
        navigationItem.rightBarButtonItem = mainView.cancelButton
        mainView.setupView()
        mainView.tableView.register(TitleEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: TitleEscreverDiarioViewCell.identifier)
        mainView.tableView.register(BodyEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: BodyEscreverDiarioViewCell.identifier)
        self.view = mainView
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationItem.largeTitleDisplayMode = .never
    }
}

extension EscreverDiarioViewController {
    func setup() {
        setupInputs()
        setupOutputs()
    }

    private func setupOutputs() {
        // Cria dataSource com Logica de Sections
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, EditarRegistroCellModel>>(
            configureCell: { _, table, _, item in
                switch item {
                case .titulo(let title):
                    return self.makeTitleCell(with: title, from: table)
                case .texto(let text):
                    return self.makeTextCell(with: text, from: table)
                }
            })

        viewModel
            .itemsDataSource
            .bind(to: mainView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.humorButton.subscribe(onNext: { _ in
            self.mainView.headerView.updateHumor()
        }).disposed(by: disposeBag)
        viewModel.weatherButton.subscribe(onNext: { _ in
            self.mainView.headerView.updateClima()
        }).disposed(by: disposeBag)

    }

    private func setupInputs() {
        mainView.cancelButton.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.saveButton.rx.tap.bind(to: viewModel.inputs.saveButton).disposed(by: disposeBag)
        mainView.navigationBackButtonItem.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        mainView.headerView.humorIconButton.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.humorLabel.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.weatherButton.rx.tap.bind(to: viewModel.weatherButton).disposed(by: disposeBag)
        mainView.headerView.weatherLabel.rx.tap.bind(to: viewModel.weatherButton).disposed(by: disposeBag)
    }
}

extension EscreverDiarioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return viewModel.heightTitle
        case 1: return viewModel.heightBody
        default: return 0.0
        }
    }
}

extension EscreverDiarioViewController {
    func makeTitleCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TitleEscreverDiarioViewCell.identifier) as? TitleEscreverDiarioViewCell
        cell?.bind(escreverRegistroViewModel: viewModel, with: tableView)
        cell?.title.text = element
        return cell ?? UITableViewCell()
    }

    func makeTextCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BodyEscreverDiarioViewCell.identifier) as? BodyEscreverDiarioViewCell
        cell?.bind(escreverRegistroViewModel: viewModel, with: tableView)
        cell?.body.text = element
        return cell ?? UITableViewCell()
    }
}
