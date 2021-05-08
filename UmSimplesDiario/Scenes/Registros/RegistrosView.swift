//
//  RegistrosView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import SnapKit
import RxSwift
import UIKit

class RegistrosView: UIView {

    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let tableView = UITableView(frame: .zero)
    let emptyStateLabel = UILabel()
    let composeButton = UIBarButtonItem(systemItem: .compose)
    let searchButton = UIBarButtonItem(systemItem: .search)
    let settingsButton = UIBarButtonItem(title: "Configurar")

    // MARK: Setup View
    func setupView() {
        self.view.frame = self.bounds
        self.view.backgroundColor = .systemBackground
        insertSubview(view, belowSubview: indicatorContainer)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        let height = CGFloat(80)
        let frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: height)
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.tableView.contentInset = UIEdgeInsets(top: -height, left: .zero, bottom: .zero, right: .zero)
        self.tableView.separatorStyle = .none
        self.tableView.register(RegistrosViewCell.self, forCellReuseIdentifier: RegistrosViewCell.identifier)
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundSky"))
        self.tableView.estimatedRowHeight = UITableView.automaticDimension

        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupEmptyStateLabel()
    }

    func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        self.emptyStateLabel.text = "Lista de registros vazia."
        self.emptyStateLabel.textColor = UIColor.systemGray2
        self.emptyStateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func emptyState(_ isEmpty: Bool) {
        emptyStateLabel.isHidden = !isEmpty
        tableView.isScrollEnabled = !isEmpty
    }
}
