//
//  ThemeViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ThemeViewController: UITableViewController {

    var viewModel: StaticViewModel?

    init(viewModel: StaticViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Configurações"
        self.tableView.backgroundView? = UIView()
        self.tableView.backgroundView?.backgroundColor = .systemBackground
        self.tableView.register(
            SwitchButtonTableViewCell.self,
            forCellReuseIdentifier: SwitchButtonTableViewCell.identifier)
    }
}
