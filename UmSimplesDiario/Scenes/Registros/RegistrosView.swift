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
    let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
    let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)

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
    
    fileprivate let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "09"
        label.textColor = StyleSheet.Color.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let dayWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Fri"
        label.textColor = StyleSheet.Color.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "12:24"
        label.textColor = StyleSheet.Color.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var titleEntry: UILabel = {
        let label = UILabel()
        label.text = "Beautiful Day"
        label.textColor = StyleSheet.Color.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var descriptionEntry: UILabel = {
        let label = UILabel()
        label.text = "Short Description that maybe end"
        label.textColor = StyleSheet.Color.primaryColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ registro: Registro) {
        self.titleEntry.text = "Titulo"
        self.descriptionEntry.text = "Descrição"
    }
    
    func setupConstraints() {
        
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.top.equalTo(contentView.snp.top).offset(8)
        }
        
        contentView.addSubview(dayWeekLabel)
        dayWeekLabel.snp.makeConstraints { make in
            make.centerX.equalTo(dayLabel.snp.centerX)
            make.top.equalTo(dayLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
        
        contentView.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.top.equalTo(contentView.snp.top).offset(8)
            
        }
        
        contentView.addSubview(titleEntry)
        titleEntry.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.top.equalTo(hourLabel.snp.bottom).offset(8)
        }
        
        contentView.addSubview(descriptionEntry)
        descriptionEntry.snp.makeConstraints { make in
            make.leading.equalTo(titleEntry.snp.leading)
            make.top.equalTo(titleEntry.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
    }
}
