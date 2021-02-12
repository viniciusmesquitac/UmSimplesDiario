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
        button.setImage(StyleSheet.Image.Mood.happyMood, for: .normal)
        return button
    }()
    
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
    
    func setupHumorIconView() {
        addSubview(humorIconButton)
        self.humorIconButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.leading.equalTo(snp.leading).offset(24)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
}
