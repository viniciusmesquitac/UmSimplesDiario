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
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let disposeBag = DisposeBag()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    let deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = StyleSheet.Color.secundaryColor
        button.setImage(.remove, for: .normal)
        button.backgroundColor = .darkGray
        return button
    }()

    override func layoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

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
