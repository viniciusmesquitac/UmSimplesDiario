//
//  RegistrosView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import SnapKit
import UIKit

class RegistrosView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let tableView = UITableView(frame: .zero)
    
    // MARK: Setup View
    func setupView() {
        self.backgroundColor = .red
        self.view.frame = self.bounds
        self.view.backgroundColor = .white
        insertSubview(view, belowSubview: indicatorContainer)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        self.tableView.backgroundColor = .none
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class RegistrosViewCell: UITableViewCell {
    static let identifier = "registros"
}
