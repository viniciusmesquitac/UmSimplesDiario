//
//  EscreverDiarioAcessoryView.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 24/02/21.
//

import UIKit

class AcessoryViewEscreverDiario: UIView {

    let keyboardDismissButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.iconKeyboard, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let imageAttachmentButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.iconImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let deleteEntryButton: SDButton = {
        let button = SDButton(frame: .zero)
        button.setImage(StyleSheet.Image.iconTrash, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = StyleSheet.Color.modalBackgroundColor
        buildViewHierarchy()
        setupConstraints()
    }

    func buildViewHierarchy() {
        self.addSubview(keyboardDismissButton)
//        self.addSubview(imageAttachmentButton)
    }

    func setupConstraints() {
        keyboardDismissButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(8)
        }
//        imageAttachmentButton.snp.makeConstraints { make in
//            make.top.bottom.leading.equalToSuperview().inset(8)
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
