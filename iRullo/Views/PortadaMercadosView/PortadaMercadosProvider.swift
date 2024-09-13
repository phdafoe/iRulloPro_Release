//
//  PortadaMercadosProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/9/24.
//

import Foundation

// Input
protocol PortadaMercadosProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataPortadaMercados()
    func fecthDataPortadaEmpresas()
    func fecthDataPortadaEconomia()
    func fecthDataPortadaVivienda()
}

final class PortadaMercadosProvider: BaseProvider {
    
    weak var viewModel: PortadaMercadosPresenterProtocol? {
        super.baseViewModel as? PortadaMercadosPresenterProtocol
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


extension PortadaMercadosProvider: PortadaMercadosProviderInputProtocol {
    
    func fecthDataPortadaMercados() {
        self.networkService.request(RequestModel(service: PortadaMercadosProviderService.portadaMercados)) { myGenericoDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadasMercados(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadasMercados(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
    }
    
    func fecthDataPortadaEmpresas() {
        self.networkService.request(RequestModel(service: PortadaMercadosProviderService.portadaEmpresas)) { myGenericoDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadasEmpresas(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadasEmpresas(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
    }
    
    func fecthDataPortadaEconomia() {
        self.networkService.request(RequestModel(service: PortadaMercadosProviderService.portadaEconomia)) { myGenericoDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadasEconomia(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadasEconomia(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
    }
    
    func fecthDataPortadaVivienda() {
        self.networkService.request(RequestModel(service: PortadaMercadosProviderService.portadaVivienda)) { myGenericoDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadasVivienda(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadasVivienda(completion: .success(self.callBackPortadasGenerico(dictionary: myGenericoDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
    }
    
    
}

enum PortadaMercadosProviderService {
    
    case portadaMercados
    case portadaEmpresas
    case portadaEconomia
    case portadaVivienda
}

extension PortadaMercadosProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHostNoticias
    }
    
    var path: String {
        switch self {
        case PortadaMercadosProviderService.portadaMercados:
            return Helpers.customUrl().portadaNoticiasMercados
        case PortadaMercadosProviderService.portadaEmpresas:
            return Helpers.customUrl().portadaNoticiasEmpresas
        case PortadaMercadosProviderService.portadaEconomia:
            return Helpers.customUrl().portadaNoticiasEconomia
        case PortadaMercadosProviderService.portadaVivienda:
            return Helpers.customUrl().portadaNoticiasVivienda
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
