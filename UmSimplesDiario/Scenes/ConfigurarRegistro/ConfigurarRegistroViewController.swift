//
//  ConfigurarEditarRegistroViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit
import RxSwift
import PanModal

class ConfigurarRegistroViewController: UIViewController {

    let mainView = ConfigurarRegistroView()
    var viewModel: ConfigurarRegistroViewModel!
    let disposeBag = DisposeBag()

    init(viewModel: ConfigurarRegistroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupView()
        self.view = mainView
        setup()
    }
    func setup() {
        setupOutputs()
        setupInputs()
    }
    func setupOutputs() { }
    func setupInputs() {
        mainView.deleteButton.rx.tap.bind(to: viewModel.deleteButton).disposed(by: disposeBag)
        mainView.saveButton.rx.tap.bind(to: viewModel.saveButton).disposed(by: disposeBag)
    }
}

extension ConfigurarRegistroViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(view.frame.height/3.5)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(view.frame.height/2)
    }

    var showDragIndicator: Bool {
        return false
    }
}
