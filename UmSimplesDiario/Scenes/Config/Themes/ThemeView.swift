//
//  ThemeView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ThemeView: UIView {

    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: .zero)
    let tableView = UITableView(frame: .zero, style: .grouped)

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
        self.tableView.backgroundColor = .systemBackground
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
