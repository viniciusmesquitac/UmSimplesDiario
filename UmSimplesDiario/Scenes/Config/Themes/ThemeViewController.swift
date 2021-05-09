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
        self.navigationItem.rightBarButtonItem = mainView.saveButton
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.register(
            SwitchButtonTableViewCell.self,
            forCellReuseIdentifier: SwitchButtonTableViewCell.identifier)
        mainView.setupView()
        self.view = mainView
        self.setup()
    }
}

extension ThemeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sections[section].items.count ?? 0
    }

   func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.sections[section].title
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel?.sections[indexPath.section].items[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        item.action?()
        item.cell.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.sections[indexPath.section].items[indexPath.row].cell else {
            return UITableViewCell()
        }
        return cell
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