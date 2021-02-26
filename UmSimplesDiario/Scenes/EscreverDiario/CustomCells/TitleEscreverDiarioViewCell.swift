//
//  TitleEscreverDiarioViewCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 24/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class TitleEscreverDiarioViewCell: UITableViewCell {
    static let identifier = "title"
    let title = UITextView()
    var heightTitle = CGFloat(120)
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

    func setupTitle() {
        addSubview(title)
        title.placeholder = "Sem titulo"
        title.isScrollEnabled = false
        rowHeight.accept(title.frame.height + 100)
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

    func bind(viewModel: EditarRegistroViewModel, with tableView: UITableView) {
        title.rx.text.bind(to: viewModel.titleText).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightTitle = height
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }).disposed(by: self.disposeBag)
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
