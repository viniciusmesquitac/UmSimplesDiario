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
    static let identifier = String(describing: type(of: self))
    let titleTextField = UITextView()

    var heightTitle = CGFloat(120)
    var rowHeight = BehaviorRelay<CGFloat>(value: 20)

    var isTitleEmpty = false
    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.backgroundColor = StyleSheet.Color.backgroundColor
        self.selectionStyle = .none
        setupTitle()

        titleTextField.tag = 0
        titleTextField.returnKeyType = .done
        titleTextField.rx.text.changed.subscribe(onNext: { text in
            self.isTitleEmpty = text == nil || text == ""
            self.rowHeight.accept(self.titleTextField.frame.height + 16)
        }).disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTitle() {
        addSubview(titleTextField)
        titleTextField.placeholder = "Sem titulo"
        titleTextField.isScrollEnabled = false
        rowHeight.accept(titleTextField.frame.height + 100)
        titleTextField.textColor = StyleSheet.Color.titleTextColor
        titleTextField.backgroundColor = StyleSheet.Color.backgroundColor
        titleTextField.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
        titleTextField.delegate = self
        titleTextField.font = StyleSheet.Font.primaryFont24
        self.titleTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }

    func bind(viewModel: EditarRegistroViewModel, with tableView: UITableView) {
        titleTextField.rx.text.bind(to: viewModel.titleText).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightTitle = height
            self.updateTableView(tableView)
        }).disposed(by: self.disposeBag)
    }

    func bind(viewModel: EscreverDiarioViewModel, with tableView: UITableView) {
        titleTextField.rx.text.bind(to: viewModel.titleText).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightTitle = height
            self.updateTableView(tableView)
        }).disposed(by: self.disposeBag)
    }
}

extension TitleEscreverDiarioViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textViewShouldChangeReturn(textView)
        }
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
              return false
          }
          return true
    }

    func textViewShouldChangeReturn(_ textView: UITextView) {
        if let nextField = self.superview?.viewWithTag(textView.tag + 1) as? UITextView {
            nextField.becomeFirstResponder()
        } else {
            textView.resignFirstResponder()
        }
    }
}
