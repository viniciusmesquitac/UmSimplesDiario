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
        self.view.backgroundColor = StyleSheet.Color.backgroundColor
        insertSubview(view, belowSubview: indicatorContainer)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = StyleSheet.Color.backgroundColor
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
