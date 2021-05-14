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
            ConfigItem(cell: createCell(title: "Escuro"), action: unselectAllCells),
            ConfigItem(cell: createCell(title: "Blue Sky"), action: unselectAllCells),
            ConfigItem(cell: createCell(title: "Pink"), action: unselectAllCells)
        ]

        sections = [
            ConfigSection(title: "Escolha um tema", items: themes)
        ]

        selectCell(at: InterfaceStyleManager.shared.style.rawValue)
    }

    private func unselectAllCells(_ sender: Any) {
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

    private func update(style: UIUserInterfaceStyle) {
        InterfaceStyleManager.shared.style = style
        didUpdateTheme?(style)
    }

    func update(theme: Styles) {
        /* Verify background is setted */
        switch theme {
        case .blue:
            print("Change colors")
        case .pink:
            print("Change colors")
        default:
            print("Padroes")
        }
        update(style: UIUserInterfaceStyle.init(rawValue: theme.rawValue) ?? .unspecified)
        coordinator.updateBackground()
    }
}

extension ThemeViewModel {
    internal func createCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.accessoryView?.backgroundColor = StyleSheet.Color.primaryColor
        cell.accessoryView?.tintColor = StyleSheet.Color.primaryColor
        cell.selectionStyle = .none
        cell.tintColor = StyleSheet.Color.primaryColor
        return cell
    }
}
