// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let portada = try? JSONDecoder().decode(Portada.self, from: jsonData)

import Foundation


struct AreaPortadas: Identifiable {
    let id: String?
    let name: String?
    let groups: [GroupPortadas]?
    let additionalProperties: AdditionalPropertiesModel?
}


