//
//  ConfigViewModel.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

class ConfigViewModel: StaticViewModel {
    var sections = [ConfigSection]()
    var coordinator: ConfigCoordinator!

    init(coordinator: ConfigCoordinator) {
        self.coordinator = coordinator
        createSections()
    }

    var securityBiometricTitle: String {
        BiometricAuthentication().type == .faceID ? "Face ID": "Touch ID"
    }

    private func createSections() {
        let customize = [
            ConfigItem(cell: createCell(title: "Temas"), action: goToTheme)
        ]
        let privacy = [
            ConfigItem(cell: createSwitchCell(title: securityBiometricTitle), action: nil)
        ]
        sections = [
            ConfigSection(title: "Customização", items: customize),
            ConfigSection(title: "Privacidade", items: privacy)
        ]
    }

    private func goToTheme() {
        coordinator.route(to: .themes)
    }

    @objc func didTapSwitchButton(_ sender: UISwitch) {
        UserDefaults.standard.setValue(sender.isOn, forKey: DefaultsEnum.isBiometricActive.rawValue)
    }

    internal func createCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView?.backgroundColor = StyleSheet.Color.activeButtonColor
        cell.accessoryView?.tintColor = StyleSheet.Color.activeButtonColor
        cell.tintColor = StyleSheet.Color.primaryColor
        return cell
    }

    internal func createSwitchCell(title: String) -> SwitchButtonTableViewCell {
        let cell = SwitchButtonTableViewCell()
        cell.switchButton.isOn = UserDefaults.standard.bool(forKey: DefaultsEnum.isBiometricActive.rawValue)
        cell.switchButton.addTarget(self, action: #selector(didTapSwitchButton), for: .touchUpInside)
        cell.contentView.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        cell.textLabel?.text = title
        cell.accessoryView?.backgroundColor = StyleSheet.Color.primaryColor
        cell.accessoryView?.tintColor = StyleSheet.Color.activeButtonColor
        cell.tintColor = StyleSheet.Color.primaryColor
        return cell
    }
}
