//
//  HeaderEscreverDiarioView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 12/02/21.
//

import Foundation


class HeaderEscreverDiarioView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    func setupView() {
        self.backgroundColor = .red
        self.view.frame = self.bounds
        self.view.backgroundColor = .white
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
