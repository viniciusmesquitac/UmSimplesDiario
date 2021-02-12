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
        static let secundaryColor = UIColor.darkGray
        static let backgroundColor = UIColor.white
        static let borderColor = UIColor.systemGray4
        
        static let titleTextColor = UIColor.systemGray
        static let bodyTextColor = UIColor.black
    }
    
    enum Font {
        static let boldTitleFont16 = UIFont.boldSystemFont(ofSize: 16)
        static let primaryFont16 = UIFont.systemFont(ofSize: 16)
        static let primaryFont24 = UIFont.systemFont(ofSize: 24)
    }
    
    enum Image {
        enum Mood {
            static let happyMood = UIImage(named: "happyMood")!
            static let sadMood = UIImage(named: "sadMood")!
        }
        
        enum Weather {
            static let fewClouds = UIImage(named: "few_clouds")!
            static let rain = UIImage(named: "rain")!
            static let showerRain = UIImage(named: "shower_rain")!
            static let clearSky = UIImage(named: "clear_sky")!
            static let thunderstorm = UIImage(named: "thunderstorm")!
        }
        
        enum Icon {
            static let ideaIcon = UIImage(named: "ideaIcon")!
        }
    }
}
