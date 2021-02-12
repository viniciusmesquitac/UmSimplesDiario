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


fileprivate var isTitleEmpty = true
fileprivate var isBodyEmpty = true

class EscreverDiarioView: UIView {
    
    let view = UIView(frame: .zero)
    let headerView = HeaderEscreverDiarioView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 30)))
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let cancelButton = UIBarButtonItem(systemItem: .cancel)
    let saveButton = UIBarButtonItem(systemItem: .save)
    let tableView = UITableView(frame: .zero)
    
    let navigationBarButtonTitle: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "TITLE",style: .plain, target: nil, action: nil)
        button.isEnabled = false
        button.tintColor = StyleSheet.Color.primaryColor
        return button
    }()
    
    func setupView() {
        self.view.frame = self.bounds
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
        self.tableView.tableHeaderView = headerView
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func setTitle(_ title: String) {
        if title.count < 24 {
            navigationBarButtonTitle.title = title
        } else {
            let endIndex = title.index(title.startIndex, offsetBy: 24)
            navigationBarButtonTitle.title = String(title[title.startIndex..<endIndex]) + "..."
        }
    }
}

class TitleEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "title"
    let title = UITextView()
    var rowHeight = BehaviorRelay<CGFloat>(value: 0)
    var isTitleEmpty = true
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle() {
        addSubview(title)
        title.placeholder = "Sem titulo"
        title.isScrollEnabled = false
        rowHeight.accept(title.frame.height)
        title.textColor = StyleSheet.Color.titleTextColor
        
        title.rx.text.changed.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isTitleEmpty = false
            } else if text == "" {
                self.isTitleEmpty = true
            }
            self.rowHeight.accept(self.title.frame.height + 16)
        }).disposed(by: disposeBag)
        
        title.font = StyleSheet.Font.primaryFont24
        self.title.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}

class BodyEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "body"
    var rowHeight = BehaviorRelay<CGFloat>(value: 0)
    let body = UITextView()
    var isBodyEmpty = true
    let disposeBag = DisposeBag()
    
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
        body.isScrollEnabled = false
        rowHeight.accept(body.frame.height + 500)
        body.placeholder = "Escreva aqui e registre sua história!"
//        body.textColor = StyleSheet.Color.bodyTextColor
        body.font = StyleSheet.Font.primaryFont16
        body.rx.text.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isBodyEmpty = false
            } else if text == "" {
                self.isBodyEmpty = true
            }
            self.rowHeight.accept(self.body.frame.height + 50)
        }).disposed(by: disposeBag)
        
        self.body.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(22)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}
