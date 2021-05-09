//
//  ThemeViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ThemeViewController: UIViewController {

    var viewModel: ThemeViewModel?
    var mainView = ThemeView()

    init(viewModel: ThemeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Temas"
        self.mainView.tableView.register(
            SwitchButtonTableViewCell.self,
            forCellReuseIdentifier: SwitchButtonTableViewCell.identifier)
        mainView.setupView()
        self.view = mainView
        self.setup()
    }
}

extension ThemeViewController {
    func setup() {
        self.setupInputs()
        self.setupOutputs()
    }

    func setupInputs() {

    }

    func setupOutputs() {

    }
}
