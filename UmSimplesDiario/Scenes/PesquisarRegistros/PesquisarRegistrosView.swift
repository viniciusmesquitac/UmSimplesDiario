//
//  PesquisarRegistrosView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 11/02/21.
//

import UIKit

class PesquisarRegistrosView: UIView {

    let view = UIView(frame: .zero)
    let searchBar = UISearchBar(frame: .zero)
    let tableView = UITableView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    func setupView() {
        self.view.backgroundColor = StyleSheet.Color.backgroundColor
        insertSubview(view, belowSubview: indicatorContainer)
        searchBar.showsCancelButton = true
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
