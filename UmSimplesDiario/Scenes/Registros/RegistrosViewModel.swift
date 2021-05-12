//
//  RegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import RxSwift
import RxCocoa
import RxDataSources

class RegistrosViewModel: RegistrosViewModelProtocol, RegistrosViewModelInput {
    var deletedItem = BehaviorRelay<IndexPath?>(value: nil)
    var itemsDataSourceRelay = BehaviorRelay<[SectionModel<String, Registro>]>(value: [])
    var searchButton = PublishSubject<Void>()
    var configButton = PublishSubject<Void>()
    var composeButton = PublishSubject<Void>()
    var selectedItem = BehaviorRelay<IndexPath?>(value: nil)

    var coordinator: RegistrosCoordinator
    let repository = RegistroRepository()
    var disposeBag = DisposeBag()

    var inputs: RegistrosViewModelInput { return self }
    var outputs: RegistrosViewModelOutput { return self }

    var listaRegistrosRelay = BehaviorRelay<[Registro]>(value: [])
    var registros: [Registro]

    init(coordinator: RegistrosCoordinator, registros: [Registro]) {
        self.coordinator = coordinator
        self.registros = registros

        loadRegistros()

        selectedItem.subscribe { indexPath in
            guard let row = indexPath.element??.row else { return }
            coordinator.route(to: .editCompose(registro: self.registros[row]))
            print(self.registros[row])

        }.disposed(by: disposeBag)

        deletedItem.subscribe { indexPath in
            guard let row = indexPath.element??.row else { return }
            _ = self.repository.delete(object: self.registros[row])
            self.registros.remove(at: row)
            self.makeSections(items: self.registros)
        }.disposed(by: disposeBag)

        configButton.subscribe(onNext: { _ in
            coordinator.route(to: .config)
        }).disposed(by: disposeBag)

        composeButton.subscribe(onNext: { _ in
            coordinator.route(to: .compose)
        }).disposed(by: disposeBag)

        searchButton.subscribe(onNext: { _ in
            coordinator.route(to: .search(registros: self.registros))
        }).disposed(by: disposeBag)

    }

    func loadRegistros() {
        self.registros = repository.getAll()
        outputs.registrosObservable.subscribe { _ in
            self.inputs.listaRegistrosRelay.accept(self.registros)
        }.disposed(by: disposeBag)

        outputs.registrosObservable.subscribe { registros in
            self.makeSections(items: registros)
        }.disposed(by: disposeBag)
    }
}

// MARK: ViewModel Output

extension RegistrosViewModel: RegistrosViewModelOutput {
    var itemsDataSource: Observable<[SectionModel<String, Registro>]> {
        self.inputs.itemsDataSourceRelay.asObservable()
    }

    var registrosObservable: Observable<[Registro]> {
        Observable.of(self.registros)
    }

    var registrosOutput: Observable<[Registro]> {
        self.inputs.listaRegistrosRelay.asObservable()
    }
}

extension RegistrosViewModel {

    func makeCell(element: Registro, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrosViewCell.identifier) as? RegistrosViewCell
        cell?.contentView.backgroundColor = StyleSheet.Color.contentEntryColor
        cell?.configure(RegistroModel(registro: element))
        return cell ?? UITableViewCell()
    }

    @discardableResult
    func makeSections(items: [Registro]) -> [SectionModel<String, Registro>] {
        let sections = SectionCell.allCases.compactMap { month -> SectionModel<String, Registro>? in
            let registros = items.filter { RegistroModel(registro: $0).month ==  month.rawValue }
            if !registros.isEmpty {
                return SectionModel<String, Registro>(model: month.sectionTitle, items: registros )
            }
            return nil
        }

        self.inputs.itemsDataSourceRelay.accept(sections)
        return sections
    }
}
