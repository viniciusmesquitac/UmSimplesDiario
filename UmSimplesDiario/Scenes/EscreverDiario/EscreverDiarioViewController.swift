//
//  EscreverDiarioViewController.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit
import RxSwift
import MapKit
import RxDataSources

class EscreverDiarioViewController: UIViewController {

    let mainView = EscreverDiarioView()
    var viewModel: EscreverDiarioViewModel!
    let disposeBag = DisposeBag()

    var heightBody = CGFloat(0)
    var heightTitle = CGFloat(0)

    let imagePicker = UIImagePickerController()

    init(viewModel: EscreverDiarioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.locationManager.delegate = self
        if viewModel.registro != nil {
            navigationItem.leftBarButtonItems = [mainView.navigationBackButtonItem, mainView.navigationBarButtonTitle]
        } else {
            navigationItem.leftBarButtonItem = mainView.navigationBarButtonTitle
        }
        navigationItem.rightBarButtonItem = mainView.cancelButton
        mainView.setupView()
        mainView.tableView.register(TitleEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: TitleEscreverDiarioViewCell.identifier)
        mainView.tableView.register(BodyEscreverDiarioViewCell.self,
                                    forCellReuseIdentifier: BodyEscreverDiarioViewCell.identifier)
        self.view = mainView
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationItem.largeTitleDisplayMode = .never
    }
}

extension EscreverDiarioViewController {
    func setup() {
        setupInputs()
        setupOutputs()
    }

    private func setupOutputs() {
        // Cria dataSource com Logica de Sections
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, EditarRegistroCellModel>>(
            configureCell: { _, table, _, item in
                switch item {
                case .titulo(let title):
                    return self.makeTitleCell(with: title, from: table)
                case .texto(let text):
                    return self.makeTextCell(with: text, from: table)
                }
            })

        viewModel
            .itemsDataSource
            .bind(to: mainView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.humorButton.subscribe(onNext: { _ in
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.mainView.headerView.updateHumor()
        }).disposed(by: disposeBag)
        viewModel.weatherButton.subscribe(onNext: { _ in
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.mainView.headerView.updateClima()
        }).disposed(by: disposeBag)

        viewModel.changeWeather.subscribe(onNext: { value in
            DispatchQueue.main.async {
                self.mainView.headerView.changeWeather(value)
                self.mainView.headerView.updateClima()
            }
        }).disposed(by: disposeBag)

        viewModel.changeHumor.asObservable().subscribe(onNext: { value in
            DispatchQueue.main.async {
                if let humor = value {
                    self.mainView.headerView.changeHumor(humor)
                    self.mainView.headerView.updateHumor()
                }
            }
        }).disposed(by: disposeBag)

        viewModel.imageButton.subscribe(onNext: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }

    private func setupInputs() {
        mainView.cancelButton.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.saveButton.rx.tap.bind(to: viewModel.inputs.saveButton).disposed(by: disposeBag)
        mainView.navigationBackButtonItem.rx.tap.bind(to: viewModel.inputs.cancelButton).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        mainView.headerView.humorIconButton.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.humorLabel.rx.tap.bind(to: viewModel.humorButton).disposed(by: disposeBag)
        mainView.headerView.weatherButton.rx.tap.bind(to: viewModel.weatherButton).disposed(by: disposeBag)
        mainView.headerView.weatherLabel.rx.tap.bind(to: viewModel.weatherButton).disposed(by: disposeBag)
    }
}

extension EscreverDiarioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return viewModel.heightTitle
        case 1: return viewModel.heightBody
        default: return 0.0
        }
    }
}

extension EscreverDiarioViewController {
    func makeTitleCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TitleEscreverDiarioViewCell.identifier) as? TitleEscreverDiarioViewCell
        cell?.bind(viewModel: viewModel, with: tableView)
        cell?.titleTextField.becomeFirstResponder()
        cell?.titleTextField.text = element

        cell?.titleTextField.rx.text.subscribe(onNext: { _ in
            self.mainView.setTitle(cell?.titleTextField.text ?? "")
            let isTitleEmpty = cell?.isTitleEmpty ?? false
            if !isTitleEmpty && !self.mainView.isBodyEmpty {
                self.navigationItem.rightBarButtonItem = self.mainView.saveButton
            } else {
                self.navigationItem.rightBarButtonItem = self.mainView.cancelButton
            }
        }).disposed(by: self.disposeBag)
        return cell ?? UITableViewCell()
    }

    func makeTextCell(with element: String, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BodyEscreverDiarioViewCell.identifier) as? BodyEscreverDiarioViewCell
        cell?.bind(viewModel: viewModel, with: tableView)
        cell?.bodyTextView.text = element
        cell?.bodyTextView.rx.text.subscribe(onNext: { _ in
            let isBodyEmpty = cell?.isBodyEmpty ?? false
            if !isBodyEmpty && !self.mainView.isTitleEmpty {
                self.navigationItem.rightBarButtonItem = self.mainView.saveButton
            } else {
                self.navigationItem.rightBarButtonItem = self.mainView.cancelButton
            }
        }).disposed(by: self.disposeBag)
        return cell ?? UITableViewCell()
    }
}

extension EscreverDiarioViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location else { return print("Error: Location nil") }
            location.placemark { placemark, _ in
                guard let cityName = placemark?.city?
                        .folding(options: .diacriticInsensitive, locale: .current)
                else { return print("Error: City not found ") }
                self.viewModel.loadClima(cityName: cityName)
            }
        }
    }
}

extension EscreverDiarioViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let cell = mainView.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BodyEscreverDiarioViewCell {
            cell.bodyTextView.setAttachment(image: pickedImage)
            /*Not implented, should create a collection to attachments **/
        }
        dismiss(animated: true)
    }
}
