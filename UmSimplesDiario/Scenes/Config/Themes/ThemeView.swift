//
//  ThemeView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ThemeView: UIView {

    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let saveButton = UIBarButtonItem(title: "Salvar")
    let tableView = UITableView(frame: .zero)

    func setupView() {
        self.view.frame = self.bounds
        self.view.backgroundColor = .systemGray5
        insertSubview(view, belowSubview: indicatorContainer)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .systemBackground
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
