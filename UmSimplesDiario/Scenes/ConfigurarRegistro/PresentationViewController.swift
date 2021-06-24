//
//  PresentationViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 03/03/21.
//

import UIKit

class PresentationController: UIPresentationController {

    let view: UIView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        view = UIView()
        view.backgroundColor = .black
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerViewFrame = self.containerView?.frame else { return .zero }
        let position = CGPoint(x: 0, y: containerViewFrame.height * 0.6)
        let size = CGSize(width: containerViewFrame.width, height: containerViewFrame.height * 0.4)
        return CGRect(origin: position, size: size)
    }

    override func presentationTransitionWillBegin() {
        self.view.alpha = 0
        self.containerView?.addSubview(view)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.view.alpha = 0.6
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.view.alpha = 0
        }, completion: { _ in
            self.view.removeFromSuperview()
        })
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        view.frame = containerView!.bounds
    }

    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true)
    }
}
