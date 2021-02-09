//
//  EscreverDiarioViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit
import RxSwift

class EscreverDiarioViewController: UIViewController {
    
    let mainView = EscreverDiarioView()
    var viewModel: EscreverDiarioViewModel!
    let disposeBag = DisposeBag()
    
    init(viewModel: EscreverDiarioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = mainView.navigationBarButtonTitle
        navigationItem.rightBarButtonItem = mainView.cancelButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        mainView.setupView()
        mainView.navigationItem = navigationItem
        mainView.tableView.register(TitleEscreverDiarioViewCell.self, forCellReuseIdentifier: TitleEscreverDiarioViewCell.identifier)
        mainView.tableView.register(BodyEscreverDiarioViewCell.self, forCellReuseIdentifier: BodyEscreverDiarioViewCell.identifier)
        self.view = mainView

        setup()
    }
}

extension EscreverDiarioViewController {
    func setup() {
        setupInputs()
        setupOutputs()
    }
    
    
    private func setupOutputs() {
        viewModel.outputs.dataSourceOutput.asObservable()
            .bind(to: mainView.tableView.rx.items) { tv, row, item in
                if row == 0 {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: TitleEscreverDiarioViewCell.identifier) as?
                            TitleEscreverDiarioViewCell else { return UITableViewCell() }
                    cell.title.text = item
                    cell.title.rx.text.bind(to: self.viewModel.titleText).disposed(by: self.disposeBag)
                    return cell
                }
                guard let cell = tv.dequeueReusableCell(withIdentifier: BodyEscreverDiarioViewCell.identifier) as?
                        BodyEscreverDiarioViewCell else { return UITableViewCell() }
                cell.body.text = item
                cell.body.rx.text.bind(to: self.viewModel.bodyText).disposed(by: self.disposeBag)
                return cell
            }.disposed(by: disposeBag)
        
    }
    
    private func setupInputs() {
        mainView.cancelButton.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
    }
}
