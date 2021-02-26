//
//  EscreverDiarioViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit
import RxSwift
import RxDataSources

class EditarRegistroViewController: UIViewController {

    let mainView = EditarRegistroView()
    var viewModel: EditarRegistroViewModel!
    let disposeBag = DisposeBag()

    init(viewModel: EditarRegistroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = mainView.navigationMoreButtonItem
        mainView.tableView.register(TitleEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: TitleEscreverDiarioViewCell.identifier)
        mainView.tableView.register(BodyEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: BodyEscreverDiarioViewCell.identifier)
        mainView.setupView()
        self.view = mainView
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationItem.largeTitleDisplayMode = .never
    }
}

extension EditarRegistroViewController {
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

        viewModel.changeHumor.asObservable().subscribe(onNext: { value in
            DispatchQueue.main.async {
                if let humor = value {
                    self.mainView.headerView.changeHumor(humor)
                    self.mainView.headerView.updateHumor()
                }
            }
        }).disposed(by: disposeBag)

        viewModel.changeWeather.asObservable().subscribe(onNext: { value in
            DispatchQueue.main.async {
                if value != .none {
                    self.mainView.headerView.changeWeather(value)
                    self.mainView.headerView.updateClima()
                }
            }
        }).disposed(by: disposeBag)
    }

    private func setupInputs() {
        mainView.cancelButton.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.saveButton.rx.tap.bind(to: viewModel.inputs.saveButton).disposed(by: disposeBag)
        mainView.navigationBackButtonItem.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        mainView.headerView.humorIconButton.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.humorLabel.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.weatherLabel.rx.tap.bind(to: viewModel.weatherButton).disposed(by: disposeBag)
    }
}

extension EditarRegistroViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return viewModel.heightTitle
        case 1: return viewModel.heightBody
        default: return 0.0
        }
    }
}

extension EditarRegistroViewController {

    func makeTitleCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TitleEscreverDiarioViewCell.identifier) as? TitleEscreverDiarioViewCell
        cell?.bind(viewModel: viewModel, with: tableView)
        cell?.title.text = element
        return cell ?? UITableViewCell()
    }

    func makeTextCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BodyEscreverDiarioViewCell.identifier) as? BodyEscreverDiarioViewCell
        cell?.bind(viewModel: viewModel, with: tableView)
        cell?.body.text = element
        return cell ?? UITableViewCell()
    }

}
