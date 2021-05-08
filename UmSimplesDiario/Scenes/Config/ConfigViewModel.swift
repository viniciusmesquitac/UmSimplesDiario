//
//  ConfigViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ConfigViewModel: StaticViewModel {
    var sections = [ConfigSection]()
    init() {
        createSections()
    }

    private func createSections() {
        let customize = [
            ConfigItem(cell: createCell(title: "Temas"), action: nil),
            ConfigItem(cell: createCell(title: "Fonte"), action: nil)
        ]
        let privacy = [
            ConfigItem(cell: createSwitchCell(title: "Face ID"), action: nil)
        ]
        sections = [
            ConfigSection(title: "Customizar", items: customize),
            ConfigSection(title: "Privacidade", items: privacy)
        ]
    }

    @objc func didTapSwitchButton(_ sender: UISwitch) {
        UserDefaults.standard.setValue(sender.isOn, forKey: DefaultsEnum.isBiometricActive.rawValue)
    }

    internal func createCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
//        cell.accessoryView?.backgroundColor = Stylesheet.Color.primaryColor
//        cell.accessoryView?.tintColor = Stylesheet.Color.primaryColor
//        cell.tintColor = Stylesheet.Color.primaryColor
        return cell
    }

    internal func createSwitchCell(title: String) -> SwitchButtonTableViewCell {
        let cell = SwitchButtonTableViewCell()
        cell.switchButton.isOn = UserDefaults.standard.bool(forKey: DefaultsEnum.isBiometricActive.rawValue)
        cell.switchButton.addTarget(self, action: #selector(didTapSwitchButton), for: .touchUpInside)
        cell.contentView.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        cell.textLabel?.text = title
//        cell.accessoryView?.backgroundColor = Stylesheet.Color.primaryColor
//        cell.accessoryView?.tintColor = Stylesheet.Color.primaryColor
//        cell.tintColor = Stylesheet.Color.primaryColor
        return cell
    }
}
