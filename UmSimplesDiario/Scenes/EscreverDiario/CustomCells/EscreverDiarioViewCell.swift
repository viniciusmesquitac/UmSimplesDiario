//
//  EscreverDiarioViewCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 17/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class TitleEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "title"
    let title = UITextView()
    var rowHeight = BehaviorRelay<CGFloat>(value: 20)
    var isTitleEmpty = true
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: EscreverDiarioViewModel) {
        title.rx.text.bind(to: viewModel.bodyText).disposed(by: disposeBag)
    }
    
    func setupTitle() {
        addSubview(title)
        title.placeholder = "Sem titulo"
        title.isScrollEnabled = false
        rowHeight.accept(title.frame.height)
        title.textColor = StyleSheet.Color.titleTextColor
        title.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
        title.delegate = self
        
        title.rx.text.changed.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isTitleEmpty = false
            } else if text == "" {
                self.isTitleEmpty = true
            }
            self.rowHeight.accept(self.title.frame.height + 16)
        }).disposed(by: disposeBag)
        
        title.font = StyleSheet.Font.primaryFont24
        self.title.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
    }
}

extension TitleEscreverDiarioViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
              // textView.resignFirstResponder() // uncomment this to close the keyboard when return key is pressed
              return false
          }

          return true
    }
}

class BodyEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "body"
    var rowHeight = BehaviorRelay<CGFloat>(value: 0)
    let body = UITextView()
    let acessoryView = AcessoryViewEscreverDiario(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
    var isBodyEmpty = true
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        setupBody()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBody() {
        addSubview(body)
        body.isScrollEnabled = false
        // body.inputAccessoryView = acessoryView
        rowHeight.accept(body.frame.height + 500)
        body.placeholder = "Escreva aqui e registre sua história!"
        body.font = StyleSheet.Font.primaryFont16
        body.rx.text.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isBodyEmpty = false
            } else if text == "" {
                self.isBodyEmpty = true
            }
            self.rowHeight.accept(self.body.frame.height + 500)
        }).disposed(by: disposeBag)
        
        self.body.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(22)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}

class AcessoryViewEscreverDiario: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}