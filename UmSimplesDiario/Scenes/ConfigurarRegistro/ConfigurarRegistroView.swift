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
    
    func setRecognizer(target: ConfigurarRegistroViewController) {
        let panGesture = UIPanGestureRecognizer(target: target, action: #selector(target.panGestureRecognizerAction))
        self.addGestureRecognizer(panGesture)
    }
}

extension ConfigurarRegistroViewController {

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }

        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                 self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
