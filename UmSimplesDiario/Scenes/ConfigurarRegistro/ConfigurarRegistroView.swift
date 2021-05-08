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
        button.backgroundColor = StyleSheet.Color.secundaryColor
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .systemBlue
        button.setImage(StyleSheet.Image.iconSave, for: .normal)
        button.layer.cornerRadius = buttonSize.height/2
        button.backgroundColor = StyleSheet.Color.secundaryColor
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
        self.view.backgroundColor = .systemBackground
        insertSubview(view, belowSubview: indicatorContainer)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupStackView()
    }

    func setupStackView() {
        let arrangedSubviews = [saveButton, deleteButton, lockButton]
        setupButtons(arrangedSubviews)
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension ConfigurarRegistroView {
    func panGestureRecognizerAction(sender: UIPanGestureRecognizer, coordinator: EditarRegistroCoordinator) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }

        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                coordinator.dismiss()
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
