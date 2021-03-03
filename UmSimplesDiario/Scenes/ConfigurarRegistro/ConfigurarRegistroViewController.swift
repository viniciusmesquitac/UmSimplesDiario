//
//  ConfigurarEditarRegistroViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 26/02/21.
//

import UIKit
import RxSwift

class ConfigurarRegistroViewController: UIViewController {

    let mainView = ConfigurarRegistroView()
    var viewModel: ConfigurarRegistroViewModel!
    
    let disposeBag = DisposeBag()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    init(viewModel: ConfigurarRegistroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLayoutSubviews() {
            if !hasSetPointOrigin {
                hasSetPointOrigin = true
                pointOrigin = self.view.frame.origin
            }
        }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupView()
        mainView.setRecognizer(target: self)
        self.view = mainView
    }

}
