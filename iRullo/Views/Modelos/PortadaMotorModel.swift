//
//  PortadaMotorModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation

struct PortadaMotorModel: Identifiable {
    var id = UUID()
    let name: String?
    var groups: [GroupPortadas]?
    let additionalProperties: AdditionalPropertiesModel?
}
