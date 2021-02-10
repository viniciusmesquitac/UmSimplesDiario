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
    let tableView = UITableView(frame: .zero)
    
    let navigationBarButtonTitle: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "TITLE",style: .plain, target: nil, action: nil)
        button.isEnabled = false
        button.tintColor = StyleSheet.Color.primaryColor
        return button
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
    
    
    func setTitle(_ title: String) {
        if title.count < 24 {
            navigationBarButtonTitle.title = title
        } else if title.count == 24 {
            navigationBarButtonTitle.title = title + "."
        }
        
        else if title.count == 25 {
            navigationBarButtonTitle.title = title + ".."
        }
        else if title.count == 26 {
            navigationBarButtonTitle.title = title + "..."
        }
    }
}

class TitleEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "title"
    let title = UITextView()
    var rowHeight: CGFloat = 0
    var isTitleEmpty = true
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        
        setupTitle()
        // title.placeholder = "Sem titulo"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle() {
        addSubview(title)
        title.isScrollEnabled = false
        title.text = "Sem título"
        rowHeight = title.frame.height
        title.textColor = UIColor.lightGray
        
        title.rx.text.changed.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isTitleEmpty = false
            } else if text == "" {
                self.isTitleEmpty = true
            }
            self.rowHeight = self.title.frame.height + 16
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
    var rowHeight: CGFloat = 0
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
        rowHeight = body.frame.height + 500
        body.font = StyleSheet.Font.primaryFont16
        body.rx.text.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isBodyEmpty = false
            } else if text == "" {
                self.isBodyEmpty = true
            }
            self.rowHeight = self.body.frame.height + 500
        }).disposed(by: disposeBag)
        
        self.body.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(22)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}
