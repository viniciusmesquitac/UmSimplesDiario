//
//  ConfigViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit
import RxSwift

class ConfigViewController: UIViewController {

    let mainView = ConfigurarRegistroView()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupView()
    }

    func setup() {
        setupOutputs()
        setupInputs()
    }

    func setupOutputs() { }
    func setupInputs() { }
}
