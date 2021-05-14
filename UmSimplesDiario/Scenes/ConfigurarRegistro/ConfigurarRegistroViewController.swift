//
//  ConfigurarEditarRegistroViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit
import RxSwift

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
        mainView.rx
          .panGesture()
            .when(.began, .changed, .ended)
          .subscribe(onNext: { sender in
            self.mainView.panGestureRecognizerAction(
                sender: sender,
                coordinator: self.viewModel.coordinator)
          })
          .disposed(by: disposeBag)
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
