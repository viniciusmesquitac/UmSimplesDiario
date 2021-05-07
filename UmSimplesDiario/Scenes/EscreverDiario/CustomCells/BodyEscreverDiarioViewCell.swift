//
//  EscreverDiarioViewCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 17/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class BodyEscreverDiarioViewCell: UITableViewCell {
    static let identifier = String(describing: type(of: self))
    var rowHeight = BehaviorRelay<CGFloat>(value: 0)
    var heightBody = CGFloat(120)

    let acessoryView = AcessoryViewEscreverDiario(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 44)))
    let bodyTextView = UITextView()

    var isBodyEmpty = true
    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        setupBody()
    }

    func bind(viewModel: EditarRegistroViewModel, with tableView: UITableView) {
        bodyTextView.rx.text.bind(to: viewModel.bodyText).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightBody = height
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }).disposed(by: self.disposeBag)
    }

    func bind(viewModel: EscreverDiarioViewModel, with tableView: UITableView) {
        bodyTextView.rx.text.bind(to: viewModel.bodyText).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightBody = height
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }).disposed(by: self.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBody() {
        addSubview(bodyTextView)
        bodyTextView.isScrollEnabled = false
        bodyTextView.inputAccessoryView = acessoryView
        rowHeight.accept(bodyTextView.frame.height + 500)
        bodyTextView.placeholder = "Escreva aqui e registre sua história!"
        bodyTextView.font = StyleSheet.Font.primaryFont16
        bodyTextView.rx.text.subscribe(onNext: { text in
            if text != nil && text != "" {
                self.isBodyEmpty = false
            } else if text == "" {
                self.isBodyEmpty = true
            }
            self.rowHeight.accept(self.bodyTextView.frame.height + 500)
        }).disposed(by: disposeBag)
        self.bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(22)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}
