//
//  PerfilViewProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/9/24.
//

import Foundation

// Input
protocol PerfilViewProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataTerminosCondiciones(completionHandler: @escaping (String?) -> ())
}

final class PerfilViewProvider: BaseProvider {
    
    let networkService: Requestable = NetworkRequestable()
    
}

extension PerfilViewProvider: PerfilViewProviderInputProtocol {
    
    func fecthDataTerminosCondiciones(completionHandler: @escaping (String?) -> ()) {
        
        self.networkService.request(RequestModel(service: PerfilViewProviderService.terminos)) { myterminosDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
            } else {
                let dic = myterminosDictionary?["terminosCondicionesResponse"] as? [String: Any]
                let string = dic?["mensaje"] as? String
                completionHandler(string)
            }
        }
    }
}

enum PerfilViewProviderService {
    case terminos
}

extension PerfilViewProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHostHeroku
    }
    
    var path: String {
        return Helpers.customUrl().terminosYCondiciones
    }
    
    var parameter: [URLQueryItem]{
        return []
    }
    
    var headers: [String : String] {
        let headerDict = [
            "Authorization": Helpers.customKeys().authHeroku
        ]
        return headerDict
    }
    
    var method: HTTPMethod {
        return .get
    }
}
