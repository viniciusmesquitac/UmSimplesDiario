//
//  SectionCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 19/02/21.
//

import Foundation

enum SectionCell: Int, CaseIterable {
    case janeiro, fevereiro, março, abril, maio,
         junho, julho, agosto, setembro, outubro,
         novembro, dezembro
    
    var sectionTitle: String {
        switch self {
        case .janeiro: return "Janeiro"
        case .fevereiro: return "Fe222vereiro"
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
