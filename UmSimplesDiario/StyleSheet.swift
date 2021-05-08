//
//  StyleSheet.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

struct StyleSheet {

    enum Color {
        static let primaryColor = UIColor(named: "primaryColor")
        static let secundaryColor = UIColor.lightGray
        static let backgroundColor = UIColor.white
        static let borderColor = UIColor.systemGray5
        static let titleTextColor = UIColor.systemGray
        static let bodyTextColor = UIColor.black
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
    }
}
