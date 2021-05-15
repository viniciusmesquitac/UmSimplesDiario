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
    var theme: Styles = .systemDefault
    var background: Background = .none

    var didUpdateTheme: ((_ style: UIUserInterfaceStyle) -> Void)?

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
            ConfigItem(cell: createCell(title: "Escuro"), action: unselectAllCells)
        ]

        let mainColors = [
            ConfigItem(cell: createCell(title: "Azul"), action: unselectAllCellsColors),
            ConfigItem(cell: createCell(title: "Vermelho"), action: unselectAllCellsColors),
            ConfigItem(cell: createCell(title: "Rosa"), action: unselectAllCellsColors),
            ConfigItem(cell: createCell(title: "Roxo"), action: unselectAllCellsColors)
        ]

        let backgrounds = [
            ConfigItem(cell: createBackgroundSelection(), action: nil)
        ]

        sections = [
            ConfigSection(title: "Escolha um tema", items: themes),
            ConfigSection(title: "Cor principal", items: mainColors),
            ConfigSection(title: "Backgrounds", items: backgrounds)
        ]

        selectCell(at: InterfaceStyleManager.shared.style.rawValue)
        selectCellColor(at: InterfaceStyleManager.shared.theme.rawValue)
    }
}

// MARK: - Updates
extension ThemeViewModel {
    func update(style: UIUserInterfaceStyle) {
        InterfaceStyleManager.shared.style = style
        didUpdateTheme?(style)
    }

    func update(theme: Theme) {
        InterfaceStyleManager.shared.theme = theme
        ThemeManager().apply(theme)
    }

    func update(background: Background) {
        InterfaceStyleManager.shared.background = background
    }
}

// MARK: - Create Datasource
extension ThemeViewModel {
    internal func createCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }

    func createBackgroundSelection() -> BackgrondsSelectionCell {
        let cell = BackgrondsSelectionCell()
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
}

// MARK: - Actions
extension ThemeViewModel {
    private func unselectAllCellsColors() {
        if sections.indices.contains(1) {
            let section = sections[1].items
            for item in section {
                item.cell.accessoryType = .none
            }
        }
    }

    private func unselectAllCells() {
        guard let section = sections.first?.items else { return }
        for item in section {
            item.cell.accessoryType = .none
        }
    }

    private func selectCell(at index: Int) {
        guard let section = sections.first?.items else { return }
        let item = section[index]
        item.cell.accessoryType = .checkmark
    }

    private func selectCellColor(at index: Int) {
        if sections.indices.contains(1) {
            let section = sections[1].items
            let item = section[index]
            item.cell.accessoryType = .checkmark
        }
    }

}
