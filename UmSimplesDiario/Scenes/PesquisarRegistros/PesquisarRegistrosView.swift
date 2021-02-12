//
//  PesquisarRegistrosView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 11/02/21.
//

import UIKit

class PesquisarRegistrosView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
        insertSubview(view, belowSubview: indicatorContainer)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupComponentView()
    }
    
    func setupComponentView() {
        // add subview + constraints
    }
}
