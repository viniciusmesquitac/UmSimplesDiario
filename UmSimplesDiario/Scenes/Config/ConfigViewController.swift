//
//  ConfigViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ConfigViewController: UITableViewController {

    var viewModel: StaticViewModel?

    init(viewModel: StaticViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Configurações"
        self.tableView.backgroundView? = UIView()
        self.view.backgroundColor = StyleSheet.Color.backgroundColor
        self.tableView.backgroundView?.backgroundColor = StyleSheet.Color.backgroundColor
        self.tableView.register(
            SwitchButtonTableViewCell.self,
            forCellReuseIdentifier: SwitchButtonTableViewCell.identifier)
    }
}

extension ConfigViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sections[section].items.count ?? 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.sections[section].title
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel?.sections[indexPath.section].items[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        item.action?()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.sections[indexPath.section].items[indexPath.row].cell else {
            return UITableViewCell()
        }
        return cell
    }
}
