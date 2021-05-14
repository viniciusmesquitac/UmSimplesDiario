//
//  ConfigSections.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/05/21.
//

import UIKit

struct ConfigSection {
    var title: String
    var items: [ConfigItem]
}

struct ConfigItem {
    let cell: UITableViewCell
    let action: ((_ sender: Any) -> Void)?
}
