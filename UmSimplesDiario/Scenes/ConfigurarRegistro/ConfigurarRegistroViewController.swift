//
//  ConfigurarEditarRegistroViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit

class ConfigurarRegistroViewController: UIViewController {

    let mainView = ConfigurarRegistroView()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        mainView.addGestureRecognizer(panGesture)
        // prepareBackgroundView()
        self.view = mainView
    }

    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect.init(style: .regular)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        mainView.insertSubview(bluredView, at: 0)
    }

    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

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
