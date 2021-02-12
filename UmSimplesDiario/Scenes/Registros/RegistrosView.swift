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
    let emptyStateLabel = UILabel()
    let composeButton = UIBarButtonItem(systemItem: .compose)
    let searchButton = UIBarButtonItem(systemItem: .search)

    // MARK: Setup View
    func setupView() {
        self.view.frame = self.bounds
        self.view.backgroundColor = .none
        insertSubview(view, belowSubview: indicatorContainer)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        self.tableView.separatorStyle = .none
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
    
    fileprivate var moodImage: UIImageView = {
        let image = UIImageView(image: StyleSheet.Image.Mood.happyMood)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate var weatherImage: UIImageView = {
        let image = UIImageView(image: StyleSheet.Image.Weather.fewClouds)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = StyleSheet.Color.primaryColor
        return image
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        contentView.layer.backgroundColor = UIColor.systemBackground.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = StyleSheet.Color.borderColor.cgColor

        self.layoutSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ title: String, in label: UILabel, limit: Int) {
        if title.count < limit {
            label.text = title
        } else {
            let endIndex = title.index(title.startIndex, offsetBy: limit)
            label.text = String(title[title.startIndex..<endIndex]) + "..."
        }
    }
    
    func configure(_ registro: RegistroModel) {
        self.setText(registro.titulo!, in: self.titleEntry, limit: 24)
        self.setText(registro.texto!, in: self.descriptionEntry, limit: 30)
        
        if registro.texto == "" {
            self.descriptionEntry.text = "Registro vazio, escreva algo aqui!"
        }
        self.dayLabel.text = registro.dia
        self.dayWeekLabel.text = registro.diaDaSemana
        self.hourLabel.text = registro.horario
        self.weatherImage.image = registro.clima
        self.moodImage.image = registro.humor
    }
    
    func setupConstraints() {
        
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.top.equalTo(contentView.snp.top).offset(16)
        }
        
        contentView.addSubview(dayWeekLabel)
        dayWeekLabel.snp.makeConstraints { make in
            make.centerX.equalTo(dayLabel.snp.centerX)
            make.top.equalTo(dayLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
        
        contentView.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.top.equalTo(contentView.snp.top).offset(16)
            
        }
        
        contentView.addSubview(titleEntry)
        titleEntry.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.top.equalTo(hourLabel.snp.bottom)
        }
        
        contentView.addSubview(weatherImage)
        weatherImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.height.equalTo(weatherImage.frame.height/2)
            make.width.equalTo(weatherImage.frame.width/2)
        }
        
        contentView.addSubview(moodImage)
        moodImage.snp.makeConstraints { make in
            make.trailing.equalTo(weatherImage.snp.leading).offset(-8)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.height.equalTo(moodImage.frame.height/2.2)
            make.width.equalTo(moodImage.frame.width/2.2)
        }
        
        contentView.addSubview(descriptionEntry)
        descriptionEntry.snp.makeConstraints { make in
            make.leading.equalTo(titleEntry.snp.leading)
            make.top.equalTo(titleEntry.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
    }
}
