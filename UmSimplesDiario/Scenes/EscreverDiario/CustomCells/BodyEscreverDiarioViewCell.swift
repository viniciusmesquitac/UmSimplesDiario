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
    static let identifier = "body"
    var rowHeight = BehaviorRelay<CGFloat>(value: 0)
    let body = UITextView()
    var heightBody = CGFloat(120)
    let acessoryView = AcessoryViewEscreverDiario(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
    var isBodyEmpty = true
    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        self.selectionStyle = .none
        setupBody()
    }

    func bind(viewModel: EditarRegistroViewModel, with tableView: UITableView) {
        backgroundColor = .white
        body.rx.text.bind(to: viewModel.bodyText).disposed(by: self.disposeBag)
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
