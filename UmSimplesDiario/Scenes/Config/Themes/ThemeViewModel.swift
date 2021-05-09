//
//  ThemeViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import RxSwift
import RxCocoa

class ThemeViewModel: ThemeViewModelProtocol, ThemeViewModelInput, ThemeViewModelOutput, StaticViewModel {
    var deleteButton = PublishSubject<Void>()
    var saveButton = PublishSubject<Void>()

    var inputs: ThemeViewModelInput { return self }
    var outputs: ThemeViewModelOutput { return self }

    var coordinator: ConfigCoordinator
    var sections = [ConfigSection]()

    let disposeBag = DisposeBag()

    init(coordinator: ConfigCoordinator) {
        self.coordinator = coordinator
        createSections()

        deleteButton.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        saveButton.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)
    }

    private func createSections() {
        let themes = [
            ConfigItem(cell: createCell(title: "Padrão do sistema"), action: unselectAllCells),
            ConfigItem(cell: createCell(title: "Claro"), action: unselectAllCells),
            ConfigItem(cell: createCell(title: "Escuro"), action: unselectAllCells),
            ConfigItem(cell: createCell(title: "Versão 君の名は。"), action: unselectAllCells)
        ]

        sections = [
            ConfigSection(title: "Escolha um tema", items: themes)
        ]
    }

    private func unselectAllCells() {
        guard let section = sections.first?.items else { return }
        for item in section {
            item.cell.accessoryType = .none
        }
    }

}

extension ThemeViewModel {
    internal func createCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.accessoryView?.backgroundColor = StyleSheet.Color.primaryColor
        cell.accessoryView?.tintColor = StyleSheet.Color.primaryColor
        cell.tintColor = StyleSheet.Color.primaryColor
        return cell
    }
}
