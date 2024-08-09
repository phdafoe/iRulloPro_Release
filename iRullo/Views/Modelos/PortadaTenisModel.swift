//
//  PortadaTenisModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import Foundation

struct PortadaTenisModel: Identifiable {
    var id = UUID()
    let name: String?
    var groups: [GroupPortadas]?
    let additionalProperties: AdditionalPropertiesModel?
}
