//
//  ConfigurarRegistroView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 03/03/21.
//

import UIKit
import RxGesture
import RxSwift

class ConfigurarRegistroView: UIView {

    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: .zero)
    let disposeBag = DisposeBag()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    let buttonSize = CGSize(width: 50, height: 50)

    lazy var deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .systemRed
        button.setImage(StyleSheet.Image.iconTrash, for: .normal)
        button.layer.cornerRadius = buttonSize.height/2
        button.backgroundColor = StyleSheet.Color.backgroundColor
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .systemBlue
        button.setImage(StyleSheet.Image.iconSave, for: .normal)
        button.layer.cornerRadius = buttonSize.height/2
        button.backgroundColor = StyleSheet.Color.backgroundColor
        return button
    }()

    lazy var lockButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .systemYellow
        button.setImage(StyleSheet.Image.iconLock, for: .normal)
        button.layer.cornerRadius = buttonSize.height/2
        button.backgroundColor = StyleSheet.Color.secundaryColor
        return button
    }()

    override func layoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

    func setupButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.snp.makeConstraints { make in
                make.size.equalTo(buttonSize)
            }
        }
    }

    func setupView() {
        self.view.frame = self.bounds
        self.view.backgroundColor = StyleSheet.Color.modalBackgroundColor
        insertSubview(view, belowSubview: indicatorContainer)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setupStackView()
    }

    func setupStackView() {
        let arrangedSubviews = [saveButton, deleteButton]
        setupButtons(arrangedSubviews)
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
    }
    var initial = CGRect.zero
}
