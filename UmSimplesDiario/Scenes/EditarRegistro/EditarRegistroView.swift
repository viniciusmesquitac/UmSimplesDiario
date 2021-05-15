//
//  EscreverDiarioView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import UITextView_Placeholder

class EditarRegistroView: UIView {

    let view = UIView(frame: .zero)
    let headerView = HeaderEscreverDiarioView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 64)))
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let cancelButton = UIBarButtonItem(title: "Cancelar")
    let saveButton = UIBarButtonItem(title: "Salvar")
    let tableView = UITableView(frame: .zero)

    let navigationMoreButtonItem: SDBarButtonItem = {
        let button = SDBarButtonItem(image: StyleSheet.Image.iconMore)
        return button
    }()

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
        self.tableView.backgroundColor = StyleSheet.Color.backgroundColor
        self.tableView.tableHeaderView = headerView
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
