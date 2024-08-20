//
//  NoticiasProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import Foundation

// Input
protocol NoticiasProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataNoticias()
}


final class NoticiasProvider: BaseProvider {
    
    weak var viewModel: NoticiasPresenterProtocol? {
        super.baseViewModel as? NoticiasPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    func callBackPortadasNoticias(dictionary: [[String: Any]]?) -> [NoticiasData]? {
        let nuevoArray = dictionary?.dropFirst(2)
        let arrayPortadaNoticias: [NoticiasData]? = nuevoArray?.compactMap {
            NoticiasData(typenameNoticia: $0["typename"] as? String,
                         titleNoticia: $0["title"] as? String,
                         subtitleNoticia: $0["subtitle"] as? String,
                         leadingNoticia: $0["leadin"] as? String,
                         urlNoticia: $0["url"] as? String,
                         bodyNoticia: $0["body"] as? String,
                         shotsNoticia: callBackShotNoticias(dictionary: $0["shots"] as? [String : Any]))
        }
        let firstPage = paginate(array: arrayPortadaNoticias ?? [], page: 1, pageSize: 10)
        return firstPage as? [NoticiasData]
    }
    
    func callBackShotNoticias(dictionary: [String: Any]?) -> ShotNoticias? {
        var shotNoticias: ShotNoticias?
        if let myDictionary = dictionary {
            let model = ShotNoticias(identificadorUno: myDictionary["1"] as? String)
            shotNoticias = model
        }
        return shotNoticias
    }
    
    func paginate(array: [Any], page: Int, pageSize: Int) -> [Any] {
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, array.count)
        
        guard startIndex < array.count else {
            return []
        }
        
        return Array(array[startIndex..<endIndex])
    }
    
}


extension NoticiasProvider: NoticiasProviderInputProtocol {
    
    func fecthDataNoticias() {
        
        self.networkService.request(RequestModel(service: NoticiasProviderService.Noticias)) { [weak self] myNoticiasDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self?.viewModel?.setNoticias(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.viewModel?.setNoticias(completion: .success(self?.callBackPortadasNoticias(dictionary: myNoticiasDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
        
    }
}

enum NoticiasProviderService {
    case Noticias
}

extension NoticiasProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHostNoticias
    }
    
    var path: String {
        return Helpers.customUrl().portadaNoticiasHome
    }
    
    var parameter: [URLQueryItem]{
        return []
    }
    
    var headers: [String : String] {
        switch self{
        case NoticiasProviderService.Noticias:
            let headerDict = [
                "Host": Helpers.customUrl().hostNoticias,
                "Accept": "*/*",
                "device" : "iPhone9,3||iOS||\(Helpers.customDevice().systemVersion)",
                "User-Agent": "\(Helpers.customDevice().systemVersion)(iOS)",
                "Accept-Language": "es"
            ]
            return headerDict
        }        
    }
    
    var method: HTTPMethod {
        return .get
    }
}
