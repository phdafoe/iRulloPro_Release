//
//  PortadaFutbolModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import Foundation

struct PortadaFutbolModel: Identifiable {
    var id = UUID()
    let name: String?
    var groups: [GroupPortadas]?
    let additionalProperties: AdditionalPropertiesModel?
}
