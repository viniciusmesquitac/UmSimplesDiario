//
//  ConfigurarRegistroView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 03/03/21.
//

import UIKit

class ConfigurarRegistroView: UIView {

    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    let deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = StyleSheet.Color.secundaryColor
        button.setImage(.remove, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()

    func setupView() {
        self.view.frame = self.bounds
        self.view.backgroundColor = .systemBackground
        insertSubview(view, belowSubview: indicatorContainer)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupDeleteButton()
    }

    func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(59)
            make.width.equalTo(59)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
}
