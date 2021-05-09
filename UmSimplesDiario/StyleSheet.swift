//
//  StyleSheet.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

struct StyleSheet {

    enum Color {
        static let primaryColor = UIColor(named: "primaryColor")!
        static let secundaryColor = UIColor.systemBackground
        static let backgroundColor = UIColor(named: "backgroundColor")!
        static let activeButtonColor = UIColor(named: "activeButtonColor")!
        static let contentEntryColor = UIColor(named: "contentEntryColor")!
        static let borderColor = UIColor.systemGray5
        static let titleTextColor = UIColor.systemGray
    }

    enum Font {
        static let boldTitleFont16 = UIFont.boldSystemFont(ofSize: 16)
        static let primaryFont16 = UIFont.systemFont(ofSize: 16)
        static let primaryFont24 = UIFont.systemFont(ofSize: 24)
        static let boldTitleFont12 = UIFont.boldSystemFont(ofSize: 16)
    }

    enum Image {
        static let happyMood = UIImage(named: "happyMood")!
        static let sadMood = UIImage(named: "sadMood")!
        static let fewClouds = UIImage(named: "few_clouds")!
        static let rain = UIImage(named: "rain")!
        static let showerRain = UIImage(named: "shower_rain")!
        static let clearSky = UIImage(named: "clear_sky")!
        static let thunderstorm = UIImage(named: "thunderstorm")!
        static let ideaIcon = UIImage(named: "ideaIcon")!
        static let iconSettings = UIImage(named: "􀍟")!
        static let iconMore = UIImage(named: "􀍠")!
        static let iconTrash = UIImage(named: "􀈒")!
        static let iconLock = UIImage(named: "􀎡")!
        static let iconSave = UIImage(named: "􀈼")!
        static let iconBackButton = UIImage(named: "backButton")
    }
}
