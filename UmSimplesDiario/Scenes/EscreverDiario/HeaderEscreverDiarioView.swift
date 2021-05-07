//
//  HeaderEscreverDiarioView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 12/02/21.
//

import UIKit

class HeaderEscreverDiarioView: UIView {
    
    let humorIconButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = StyleSheet.Color.secundaryColor
        button.setImage(StyleSheet.Image.Mood.happyMood, for: .normal)
        return button
    }()
    
    let ideaIconButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = StyleSheet.Color.secundaryColor
        button.setImage(StyleSheet.Image.Icon.ideaIcon, for: .normal)
        return button
    }()
    
    let weatherButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = StyleSheet.Color.secundaryColor
        button.setImage(StyleSheet.Image.Weather.fewClouds, for: .normal)
        return button
    }()
    
    let humorLabel = UIButton(frame: .zero)
    let weatherLabel = UIButton(frame: .zero)
    let ideaLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupHumorIconView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeHumor(_ value: Bool) {
        if value {
            humorIconButton.setImage(StyleSheet.Image.Mood.sadMood, for: .normal)
        } else {
            humorIconButton.setImage(StyleSheet.Image.Mood.happyMood, for: .normal)
        }
    }

    func changeWeather(_ value: WeatherKeyResult) {
        let imageNamed = value.rawValue.split(separator: " ").joined(separator: "_")
        guard let image = UIImage(named: imageNamed) else {
            return
        }
        self.weatherButton.setImage(image, for: .normal)
    }

    func updateHumor() {
        self.humorIconButton.translatesAutoresizingMaskIntoConstraints = false
        self.humorIconButton.tintColor = UIColor.systemBlue
        self.humorLabel.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.width.equalTo(0)
        }
        
        self.humorIconButton.snp.removeConstraints()
        self.humorIconButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }

    func updateClima() {
        self.weatherButton.tintColor = UIColor.systemBlue
        self.weatherLabel.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.width.equalTo(0)
        }

        self.weatherButton.snp.removeConstraints()
        self.weatherButton.snp.makeConstraints { make in
            make.centerY.equalTo(humorIconButton.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-16)
            make.height.equalTo(18)
            make.width.equalTo(24)
        }
    }

    func setupHumorIconView() {
        addSubview(humorIconButton)
        self.humorIconButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.height.equalTo(12)
            make.width.equalTo(12)
        }
        setupHumorLabel()
    }
    
    func setupHumorLabel() {
        addSubview(humorLabel)
        humorLabel.setTitle("Inserir Humor", for: .normal)
        humorLabel.titleLabel?.font = StyleSheet.Font.boldTitleFont12
        humorLabel.setTitleColor(StyleSheet.Color.secundaryColor, for: .normal)
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
            make.height.equalTo(12)
            make.width.equalTo(16)
        }
        setupWeatherLabel()
    }

    func setupWeatherLabel() {
        addSubview(weatherLabel)
        weatherLabel.setTitle("Inserir Clima", for: .normal)
        weatherLabel.titleLabel?.font = StyleSheet.Font.boldTitleFont12
        weatherLabel.setTitleColor(StyleSheet.Color.secundaryColor, for: .normal)
        self.weatherLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherButton.snp.trailing).offset(8)
            make.centerY.equalTo(weatherButton.snp.centerY)
        }
    }
}
