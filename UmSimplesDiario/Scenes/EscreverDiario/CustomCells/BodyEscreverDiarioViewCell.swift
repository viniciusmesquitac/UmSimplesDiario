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
    let increaseRowHeight = CGFloat(500)

    let acessoryView = AcessoryViewEscreverDiario(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 32)))
    let bodyTextView = UITextView()

    var isBodyEmpty = false
    let disposeBag = DisposeBag()
    var positionTapped = BehaviorRelay<CGPoint>(value: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        bodyTextView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapResponse))
        tap.delegate = self
        bodyTextView.addGestureRecognizer(tap)
        bodyTextView.delegate = self
        acessoryView.keyboardDismissButton.addTarget(self, action: #selector(dimissKeyboard), for: .allEvents)
        self.selectionStyle = .none
        bodyTextView.isUserInteractionEnabled = true
        self.backgroundColor = StyleSheet.Color.backgroundColor
        setupBody()
    }

    func bind(viewModel: EditarRegistroViewModel, with tableView: UITableView) {
        bodyTextView.rx.text.bind(to: viewModel.bodyText).disposed(by: self.disposeBag)
        acessoryView.imageAttachmentButton.rx.tap.bind(to: viewModel.imageButton).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightBody = height
            self.updateTableView(tableView)
        }).disposed(by: self.disposeBag)

        positionTapped.asObservable().subscribe(onNext: { value in
            tableView.scrollRectToVisible(
                CGRect(origin: CGPoint(x: .zero, y: value.y - 100),
                       size: tableView.frame.size),
                animated: true)
        }).disposed(by: disposeBag)

//        bodyTextView.rx.text.changed.skip(1).subscribe(onNext: { _ in
//            tableView.scrollRectToVisible(
//                CGRect(origin: CGPoint(x: .zero, y: self.positionTapped.value.y),
//                       size: tableView.frame.size),
//                animated: false)
//        }).disposed(by: disposeBag)

    }

    func bind(viewModel: EscreverDiarioViewModel, with tableView: UITableView) {
        bodyTextView.rx.text.bind(to: viewModel.bodyText).disposed(by: self.disposeBag)
        acessoryView.imageAttachmentButton.rx.tap.bind(to: viewModel.imageButton).disposed(by: self.disposeBag)
        self.rowHeight.subscribe(onNext: { height in
            viewModel.heightBody = height
            self.updateTableView(tableView)
        }).disposed(by: self.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBody() {
        bodyTextView.tag = 1
        addSubview(bodyTextView)
        bodyTextView.isScrollEnabled = false
        bodyTextView.inputAccessoryView = acessoryView
        rowHeight.accept(bodyTextView.frame.height + self.increaseRowHeight)
        bodyTextView.placeholder = "Escreva aqui e registre sua história!"
        bodyTextView.backgroundColor = StyleSheet.Color.backgroundColor
        bodyTextView.font = StyleSheet.Font.primaryFont16
        bodyTextView.rx.text.subscribe(onNext: { text in
            self.isBodyEmpty = text == nil || text == ""
            self.rowHeight.accept(self.bodyTextView.frame.height + self.increaseRowHeight)
        }).disposed(by: disposeBag)
        self.bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(22)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }

    @objc func dimissKeyboard() {
        self.bodyTextView.resignFirstResponder()
    }

    @objc func tapResponse(_ recognizer: UITapGestureRecognizer) {
        let location: CGPoint = recognizer.location(in: bodyTextView)
        self.positionTapped.accept(location)
    }

    override func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UITableViewCell {
    func updateTableView(_ tableView: UITableView) {
        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

extension BodyEscreverDiarioViewCell: UITextViewDelegate {
    func textViewShouldChangeReturn(_ textView: UITextView) {
        let position = self.positionTapped.value
        let newPosition = position.y + 50
        self.positionTapped.accept(CGPoint(x: position.x, y: newPosition))
    }
}
