//
//  RegistrosViewCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 17/02/21.
//

import UIKit

class RegistrosViewCell: UITableViewCell {
    static let identifier = "registros"

    var backgroundAlpha: CGFloat = 0.8

    fileprivate let dayLabel: SDLabel = {
        let label = SDLabel()
        label.text = "32"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let dayWeekLabel: SDLabel = {
        let label = SDLabel()
        label.text = "Fri"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let hourLabel: SDLabel = {
        let label = SDLabel()
        label.text = "12:24"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate var titleEntry: SDLabel = {
        let label = SDLabel()
        label.text = "Beautiful Day"
        label.font = StyleSheet.Font.boldTitleFont16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate var descriptionEntry: UILabel = {
        let label = UILabel()
        label.text = "Short Description that maybe end"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate var moodImage: SDImageView = {
        let image = SDImageView(image: StyleSheet.Image.happyMood)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    fileprivate var weatherImage: SDImageView = {
        let image = SDImageView(image: StyleSheet.Image.fewClouds)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        contentView.layer.backgroundColor = UIColor.clear.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = StyleSheet.Color.borderColor.cgColor

        self.layoutSubviews()
        buildViewHierarchy()
        setupConstraints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            contentView.layer.borderColor = StyleSheet.Color.borderColor.cgColor
            contentView.layer.backgroundColor = StyleSheet.Color.contentEntryColor
                .withAlphaComponent(backgroundAlpha).cgColor
           }
       }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.backgroundColor = StyleSheet.Color.contentEntryColor
            .withAlphaComponent(backgroundAlpha).cgColor
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
        let defaultTextEntry = "Registro vazio, escreva algo aqui!"
        self.setText(registro.titulo ?? "", in: self.titleEntry, limit: 24)
        self.setText(registro.texto ?? defaultTextEntry, in: self.descriptionEntry, limit: 30)
        if registro.texto == "" {
            self.descriptionEntry.text = defaultTextEntry
        }
        self.dayLabel.text = registro.day
        self.dayWeekLabel.text = registro.daysOfWeek
        self.hourLabel.text = registro.time
        self.weatherImage.image = registro.weather
        self.moodImage.image = registro.humor
    }

    func buildViewHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(dayWeekLabel)
        contentView.addSubview(hourLabel)
        contentView.addSubview(titleEntry)
        contentView.addSubview(descriptionEntry)
        contentView.addSubview(weatherImage)
        contentView.addSubview(moodImage)
    }

    func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalToSuperview().offset(-8)
            make.width.equalTo(32)
        }
        dayWeekLabel.snp.makeConstraints { make in
            make.centerX.equalTo(dayLabel.snp.centerX)
            make.top.equalTo(dayLabel.snp.bottom)
        }
        hourLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.centerY.equalTo(dayLabel).offset(-8)
        }
        titleEntry.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(8)
            make.top.equalTo(hourLabel.snp.bottom).offset(3)
        }
        descriptionEntry.snp.makeConstraints { make in
            make.leading.equalTo(titleEntry.snp.leading)
            make.top.equalTo(titleEntry.snp.bottom).offset(3)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        weatherImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.height.equalTo(weatherImage.frame.height/2)
            make.width.equalTo(weatherImage.frame.width/2)
        }
        moodImage.snp.makeConstraints { make in
            make.trailing.equalTo(weatherImage.snp.leading).offset(-8)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.height.equalTo(moodImage.frame.height/2.2)
            make.width.equalTo(moodImage.frame.width/2.2)
        }
    }
}

class SectionRegistrosHeaderView: UITableViewHeaderFooterView {
    // MARK: Setup View
    func setupView() {
        self.backgroundColor = .none
    }
}
