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
        
        navigationItem.leftBarButtonItem = mainView.navigationBarButtonTitle
        navigationItem.rightBarButtonItem = mainView.cancelButton
        mainView.setupView()
        mainView.tableView.register(TitleEscreverDiarioViewCell.self, forCellReuseIdentifier: TitleEscreverDiarioViewCell.identifier)
        mainView.tableView.register(BodyEscreverDiarioViewCell.self, forCellReuseIdentifier: BodyEscreverDiarioViewCell.identifier)
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
        viewModel.outputs.dataSourceOutput.asObservable()
            .bind(to: mainView.tableView.rx.items) { tv, row, item in
                var isTitleEmpty = false
                var isBodyEmpty = false
                
                if row == 0 {
                    guard let cell = tv.dequeueReusableCell(withIdentifier: TitleEscreverDiarioViewCell.identifier) as?
                            TitleEscreverDiarioViewCell else { return UITableViewCell() }
                    cell.title.text = item
                    cell.title.rx.text.bind(to: self.viewModel.titleText).disposed(by: self.disposeBag)
                    cell.rowHeight.subscribe(onNext: { height in
                        self.heightTitle = height
                        UIView.performWithoutAnimation {
                            tv.beginUpdates()
                            tv.endUpdates()
                        }
                    }).disposed(by: self.disposeBag)
                    
                    cell.title.rx.text.subscribe(onNext: { _ in
                        self.mainView.setTitle(cell.title.text)
                        isTitleEmpty = cell.isTitleEmpty
                        if !cell.isTitleEmpty && !isBodyEmpty { self.navigationItem.rightBarButtonItem = self.mainView.saveButton } else {
                            self.navigationItem.rightBarButtonItem = self.mainView.cancelButton
                        }
                    }).disposed(by: self.disposeBag)
                    return cell
                }
                guard let cell = tv.dequeueReusableCell(withIdentifier: BodyEscreverDiarioViewCell.identifier) as?
                        BodyEscreverDiarioViewCell else { return UITableViewCell() }
                cell.body.text = item
                
                cell.rowHeight.subscribe(onNext: { height in
                    self.heightBody = height
                    UIView.performWithoutAnimation {
                        tv.beginUpdates()
                        tv.endUpdates()
                    }
                }).disposed(by: self.disposeBag)
                
                cell.body.rx.text.bind(to: self.viewModel.bodyText).disposed(by: self.disposeBag)
                cell.body.rx.text.subscribe(onNext: { _ in
                    isBodyEmpty = cell.isBodyEmpty
                    if !cell.isBodyEmpty && !isTitleEmpty { self.navigationItem.rightBarButtonItem = self.mainView.saveButton } else {
                        self.navigationItem.rightBarButtonItem = self.mainView.cancelButton
                    }
                }).disposed(by: self.disposeBag)
                return cell
            }.disposed(by: disposeBag)
        
    }
    
    private func setupInputs() {
        mainView.cancelButton.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.saveButton.rx.tap.bind(to: viewModel.inputs.saveButton).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
}

extension EscreverDiarioViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return heightTitle
        }
        
        if indexPath.row == 1 {
            return heightBody
        }
        return 0.0
    }

}
