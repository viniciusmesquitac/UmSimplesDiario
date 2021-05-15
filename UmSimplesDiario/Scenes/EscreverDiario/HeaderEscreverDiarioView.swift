//
//  HeaderEscreverDiarioView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 12/02/21.
//

import UIKit

class HeaderEscreverDiarioView: UIView {
    
    let humorIconSize = CGSize(width: 24, height: 24)
    let weatherIconSize = CGSize(width: 32, height: 32)

    let humorIconButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.happyMood, for: .normal)
        button.isSelected = false
        return button
    }()

    let ideaIconButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.ideaIcon, for: .normal)
        return button
    }()

    let weatherButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.fewClouds, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.isSelected = false
        return button
    }()

    let humorLabel = SDButton(frame: .zero)
    let weatherLabel = SDButton(frame: .zero)
    let ideaLabel = SDLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = StyleSheet.Color.backgroundColor
        setupHumorIconView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeHumor(_ value: Bool) {
        humorIconButton.isSelected = true
        if value {
            humorIconButton.setImage(StyleSheet.Image.sadMood, for: .selected)
        } else {
            humorIconButton.setImage(StyleSheet.Image.happyMood, for: .selected)
        }
    }

    func changeWeather(_ value: WeatherKeyResult) {
        weatherButton.isSelected = true
        let imageNamed = value.rawValue.split(separator: " ").joined(separator: "_")
        guard let image = UIImage(named: imageNamed) else {
            return
        }
        self.weatherButton.setImage(image, for: .normal)
    }

    func updateHumor() {
        self.humorIconButton.translatesAutoresizingMaskIntoConstraints = false
        self.humorLabel.snp.makeConstraints { make in
            make.height.width.equalTo(0)
        }
        self.humorIconButton.snp.removeConstraints()
        self.humorIconButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.height.width.equalTo(humorIconSize.height)
        }
    }

    func updateClima() {
        self.weatherLabel.snp.makeConstraints { make in
            make.height.width.equalTo(0)
        }
        self.weatherButton.snp.removeConstraints()
        self.weatherButton.snp.makeConstraints { make in
            make.centerY.equalTo(humorIconButton.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-16)
            make.height.width.equalTo(weatherIconSize.height)
        }
    }

    func setupHumorIconView() {
        addSubview(humorIconButton)
        self.humorIconButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.height.width.equalTo(humorIconSize.height)
        }
        setupHumorLabel()
    }

    func setupHumorLabel() {
        addSubview(humorLabel)
        humorLabel.setTitle("Inserir humor", for: .normal)
        humorLabel.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        humorLabel.setTitleColor(StyleSheet.Color.titleTextColor, for: .normal)
        self.humorLabel.snp.makeConstraints { make in
            make.leading.equalTo(humorIconButton.snp.trailing).offset(8)
            make.centerY.equalTo(humorIconButton.snp.centerY)
        }
        setupWeatherButtonView()
    }

    func setupWeatherButtonView() {
        addSubview(weatherButton)
        self.weatherButton.snp.makeConstraints { make in
            make.centerY.equalTo(humorIconButton.snp.centerY)
            make.leading.equalTo(humorLabel.snp.trailing).offset(16)
            make.height.width.equalTo(weatherIconSize.height)
        }
        setupWeatherLabel()
    }

    func setupWeatherLabel() {
        addSubview(weatherLabel)
        weatherLabel.setTitle("Clima", for: .normal)
        weatherLabel.titleLabel?.font = StyleSheet.Font.boldTitleFont12
        weatherLabel.setTitleColor(StyleSheet.Color.secundaryColor, for: .normal)
        self.weatherLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherButton.snp.trailing).offset(8)
            make.centerY.equalTo(weatherButton.snp.centerY)
        }
    }
}
