//
//  EscreverDiarioView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/02/21.
//

import UIKit
import SnapKit
import RxSwift


fileprivate var isTitleEmpty = true
fileprivate var isBodyEmpty = true

class EscreverDiarioView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let cancelButton = UIBarButtonItem(systemItem: .cancel)
    let saveButton = UIBarButtonItem(systemItem: .save)
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let navigationBarButtonTitle: UIBarButtonItem = {
        let label = UILabel()
        label.text = "titulo"
        return UIBarButtonItem.init(customView: label)
    }()
    
    func setupView() {
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
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class TitleEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "title"
    let title = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        
        setupTitle()
        title.placeholder = "Sem titulo"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle() {
        addSubview(title)
        self.title.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
        }
    }
    
}

class BodyEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "body"
    let body = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        setupBody()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBody() {
        addSubview(body)
        self.body.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
        }
    }
}
