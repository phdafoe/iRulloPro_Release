//
//  GenericaNoticiasDestacadasProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/9/24.
//

import Foundation

// Input
protocol GenericaNoticiasDestacadasProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataPortadaGenerico(name: String)
}


final class GenericaNoticiasDestacadasProvider: BaseProvider {
    
    weak var viewModel: GenericaNoticiasDestacadasPresenterProtocol? {
        super.baseViewModel as? GenericaNoticiasDestacadasPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    func callBackPortadasGenerico(dictionary: [[String: Any]]?) -> [NoticiasData]? {
        let nuevoArray = dictionary
        let arrayPortadaNoticias: [NoticiasData]? = nuevoArray?.compactMap {
            NoticiasData(typenameNoticia: $0["typename"] as? String,
                         titleNoticia: $0["title"] as? String,
                         subtitleNoticia: $0["subtitle"] as? String,
                         leadingNoticia: $0["leadin"] as? String,
                         urlNoticia: $0["url"] as? String,
                         bodyNoticia: $0["body"] as? String,
                         shotsNoticia: callBackShotNoticias(dictionary: $0["shots"] as? [String : Any]))
        }
        return arrayPortadaNoticias
    }
    
    func callBackShotNoticias(dictionary: [String: Any]?) -> ShotNoticias? {
        var shotNoticias: ShotNoticias?
        if let myDictionary = dictionary {
            let model = ShotNoticias(identificadorUno: myDictionary["1"] as? String)
            shotNoticias = model
        }
        return shotNoticias
    }
    
}

extension GenericaNoticiasDestacadasProvider: GenericaNoticiasDestacadasProviderInputProtocol {
    
    func fecthDataPortadaGenerico(name: String) {
        
        switch name {
        case "Cataluna":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaCatalunya)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        case "Valenciana":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaValenciana)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        case "Aragon":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaAragon)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        case "Vasco":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaVasco)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        case "Galicia":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaGalicia)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        case "Mercados":
            self.networkService.request(RequestModel(service: GenericaNoticiasDestacadasProviderService.portadaMercados)) { myGenericoDictionary, error in
                if let errorUnw = error  {
                    print(errorUnw)
                    self.viewModel?.setPortadaGenerico(completion: .failure(errorUnw))
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.setPortadaGenerico(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                    }
                }
            }
        default:
            break
        }   
    }
}

enum GenericaNoticiasDestacadasProviderService {
    case portadaCatalunya
    case portadaValenciana
    case portadaAragon
    case portadaVasco
    case portadaGalicia
    case portadaMercados
}

extension GenericaNoticiasDestacadasProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHostNoticias
    }
    
    var path: String {
        switch self {
        case GenericaNoticiasDestacadasProviderService.portadaCatalunya:
            return Helpers.customUrl().portadaNoticiasCatalunia
        case GenericaNoticiasDestacadasProviderService.portadaValenciana:
            return Helpers.customUrl().portadaNoticiasValenciana
        case GenericaNoticiasDestacadasProviderService.portadaAragon:
            return Helpers.customUrl().portadaNoticiasAragon
        case GenericaNoticiasDestacadasProviderService.portadaVasco:
            return Helpers.customUrl().portadaNoticiasPaisVacsco
        case GenericaNoticiasDestacadasProviderService.portadaGalicia:
            return Helpers.customUrl().portadaNoticiasGalicia
        case GenericaNoticiasDestacadasProviderService.portadaMercados:
            return Helpers.customUrl().portadaNoticiasMercados
        }
    }
    
    var parameter: [URLQueryItem]{
        return []
    }
    
    var headers: [String : String] {
        return [
            "Host": Helpers.customUrl().hostNoticias,
            "Accept": "*/*",
            "device" : "iPhone9,3||iOS||\(Helpers.customDevice().systemVersion)",
            "User-Agent": "AS/\(Helpers.customDevice().systemVersion)(iOS)",
            "Accept-Language": "es"
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
