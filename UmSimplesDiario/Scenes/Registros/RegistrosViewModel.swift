//
//  RegistrosViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import RxSwift
import RxCocoa
import RxDataSources

protocol RegistrosViewModelInput {
    var selectedItem: BehaviorRelay<IndexPath?> { get }
    var composeButton: PublishSubject<Void> { get }
    var searchButton: PublishSubject<Void> { get }
    var listaRegistrosRelay: BehaviorRelay<[Registro]> { get }
    var itemsDataSourceRelay: BehaviorRelay<[SectionModel<String, Registro>]> { get }
}

protocol RegistrosViewModelOutput {
    var registrosObservable: Observable<[Registro]> { get }
    var registrosOutput: Observable<[Registro]> { get }
    var itemsDataSource: Observable<[SectionModel<String, Registro>]> { get }
    func loadRegistros()
}

protocol RegistrosViewModelProtocol: ViewModel {
    var inputs: RegistrosViewModelInput { get }
    var outputs: RegistrosViewModelOutput { get }
}

class RegistrosViewModel: RegistrosViewModelProtocol, RegistrosViewModelInput {
    var itemsDataSourceRelay = BehaviorRelay<[SectionModel<String, Registro>]>(value: [])
    
    var searchButton = PublishSubject<Void>()
    
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
        
        composeButton.subscribe(onNext: { _ in
            coordinator.route(to: .compose)
        }).disposed(by: disposeBag)
        
        searchButton.subscribe(onNext: { _ in
            coordinator.route(to: .search(registros: self.registros))
        }).disposed(by: disposeBag)

    }

    
    func loadRegistros() {
        self.registros = repository.getAll()
        outputs.registrosObservable.subscribe { value in
            _ = self.makeSections(items: value)
//            self.inputs.listaRegistrosRelay.accept(self.registros)
        }.disposed(by: disposeBag)
        
        outputs.registrosObservable.subscribe { value in
            self.inputs.listaRegistrosRelay.accept(self.registros)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrosViewCell.identifier) as! RegistrosViewCell
        cell.configure(RegistroModel(registro: element))
        return cell
    }
    
    func makeSections(items: [Registro]) -> [SectionModel<String, Registro>] {
        let sections = SectionCell.allCases.compactMap { mes -> SectionModel<String, Registro>? in
            let registros = items.filter { RegistroModel(registro: $0).mes ==  mes.rawValue }
            if !registros.isEmpty {
                return SectionModel<String, Registro>(model: mes.sectionTitle, items: registros )
            }
            return nil
        }
        
        self.inputs.itemsDataSourceRelay.accept(sections)
        return sections
    }
}

enum SectionCell: Int, CaseIterable {
    case janeiro, fevereiro, março, abril, maio,
         junho, julho, agosto, setembro, outubro,
         novembro, dezembro
    
    var sectionTitle: String {
        switch self {
        case .janeiro: return "Janeiro"
        case .fevereiro: return "Fevereiro"
        case .março: return "Março"
        case .abril: return "Abril"
        case .maio: return "Maio"
        case .junho: return "Junho"
        case .julho: return "Julho"
        case .agosto: return "Agosto"
        case .setembro: return "Setembro"
        case .outubro: return "Outubro"
        case .novembro: return "Novembro"
        case .dezembro: return "Dezembro"
        }
    }
}
