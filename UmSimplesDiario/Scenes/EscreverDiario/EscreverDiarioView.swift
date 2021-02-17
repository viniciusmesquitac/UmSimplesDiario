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
    let headerView = HeaderEscreverDiarioView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 45)))
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let cancelButton = UIBarButtonItem(systemItem: .cancel)
    let saveButton = UIBarButtonItem(systemItem: .save)
    let tableView = UITableView(frame: .zero)
    
    let navigationBarButtonTitle: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "title",style: .plain, target: nil, action: nil)
        button.isEnabled = false
        button.tintColor = StyleSheet.Color.secundaryColor
        return button
    }()
    
    let navigationBackButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: nil, action: nil)
        button.tintColor = UIColor.systemBlue
        return button
    }()
    
    let navigationMoreButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: nil, action: nil)
        button.tintColor = UIColor.systemBlue
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
        self.tableView.backgroundColor = .systemBackground
        self.tableView.tableHeaderView = headerView
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func setTitle(_ title: String) {
        if title.count < 20 {
            navigationBarButtonTitle.title = title
        } else {
            let endIndex = title.index(title.startIndex, offsetBy: 20)
            navigationBarButtonTitle.title = String(title[title.startIndex..<endIndex]) + "..."
        }
    }
}
