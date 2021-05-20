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
    let emptyState = EmptyStateView()
    let composeButton = SDBarButtonItem(systemItem: .compose)
    let searchButton = SDBarButtonItem(systemItem: .search)
    let settingsButton = SDBarButtonItem(image: StyleSheet.Image.iconSettings)

    // MARK: Setup View
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
        let height = CGFloat(80)
        let frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: height)
        self.tableView.backgroundColor = StyleSheet.Color.backgroundColor
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.tableView.contentInset = UIEdgeInsets(top: -height, left: .zero, bottom: .zero, right: .zero)
        self.tableView.separatorStyle = .none
        self.tableView.register(RegistrosViewCell.self, forCellReuseIdentifier: RegistrosViewCell.identifier)
        self.tableView.rowHeight = 100

        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let backgroundName = InterfaceStyleManager.shared.background.rawValue
        if backgroundName != Background.allCases.first?.rawValue {
            self.tableView.backgroundView = UIImageView(image: UIImage(named: backgroundName))
        } else {
            self.tableView.backgroundView = nil
        }
        setupEmptyState()
    }

    func updateBackground() {
        let backgroundName = InterfaceStyleManager.shared.background.rawValue
        if backgroundName != Background.allCases.first?.rawValue {
            self.tableView.backgroundView = UIImageView(image: UIImage(named: backgroundName))
        } else {
            self.tableView.backgroundView = nil
        }
        self.tableView.backgroundView?.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.tableView.backgroundView?.alpha = 1
        }
    }

    func setupEmptyState() {
        emptyState.titleLabel.textColor = StyleSheet.Color.primaryColor
        emptyState.subTitleLabel.textColor = StyleSheet.Color.primaryColor
        emptyState.imageView.tintColor = StyleSheet.Color.primaryColor
        view.addSubview(emptyState)
        self.emptyState.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func emptyState(_ isEmpty: Bool) {
        emptyState.isHidden = !isEmpty
        tableView.isScrollEnabled = !isEmpty
    }
}

class EmptyStateView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lista de registros vazia."
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor.systemGray2
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Para começar a escrever toque no icone"
        label.textColor = UIColor.systemGray2
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = StyleSheet.Image.iconCompose
        imageView.tintColor = .systemGray2
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(imageView)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}
