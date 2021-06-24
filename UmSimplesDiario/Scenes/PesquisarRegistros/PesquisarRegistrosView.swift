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
    let emptyState = EmptyStateView()
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    func setupView() {
        self.view.backgroundColor = StyleSheet.Color.backgroundColor
        insertSubview(view, belowSubview: indicatorContainer)
        searchBar.showsCancelButton = true
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
        setupEmptyState()
    }

    func setupEmptyState() {
        view.addSubview(emptyState)
        emptyState.titleLabel.text = "Pesquisar registro"
        emptyState.titleLabel.font = .boldSystemFont(ofSize: 24)
        emptyState.titleLabel.textColor = StyleSheet.Color.primaryColor
        emptyState.imageView.isHidden = true
        emptyState.subTitleLabel.text = "Pesquise por dia, titulo ou descrição"
        self.emptyState.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
        }
    }

    func emptyState(_ isEmpty: Bool) {
        emptyState.isHidden = !isEmpty
        tableView.isScrollEnabled = !isEmpty
    }

    func setupTableView() {
        view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 100
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
