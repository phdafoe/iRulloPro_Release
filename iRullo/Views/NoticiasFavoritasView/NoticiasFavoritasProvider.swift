//
//  NoticiasFavoritasProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 11/9/24.
//

import Foundation

// Input
protocol NoticiasFavoritasProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataPortadaFavoritas()
}

final class NoticiasFavoritasProvider: BaseProvider {
    
    weak var viewModel: NoticiasFavoritasPresenterProtocol? {
        super.baseViewModel as? NoticiasFavoritasPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    
    func getFromFirebaseFavouritesMovies(completionHandler: @escaping (DownloadNewModels?) -> ()) {
        DDBB.shared.getAllLocal { favoritesData in
            completionHandler(favoritesData)
        } failure: { error in
            debugPrint("favoritesData not saved correctly")
        }
    }
    
}

extension NoticiasFavoritasProvider: NoticiasFavoritasProviderInputProtocol {
    
    func fecthDataPortadaFavoritas() {
        
        self.getFromFirebaseFavouritesMovies { arrayData in
            
            arrayData?.downloads.map{ item in
                
                DispatchQueue.main.async {
                    
                    let nuevoArrayNoticiasData = item
                    let arrayPortadaNoticias: [NoticiasData]? = nuevoArrayNoticiasData.compactMap {
                        NoticiasData(typenameNoticia: $0.typenameNoticia,
                                     titleNoticia: $0.titleNoticia,
                                     subtitleNoticia: $0.subtitleNoticia,
                                     leadingNoticia: $0.leadingNoticia,
                                     urlNoticia: $0.urlNoticia,
                                     bodyNoticia: $0.bodyNoticia,
                                     shotsNoticia: self.callBackShotNoticias(dictionary: $0.shotsNoticia))
                    }
               
                    self.viewModel?.setPortadaGenerico(completion: .success(arrayPortadaNoticias))
                }
            }
        }
    }
    
    func callBackShotNoticias(dictionary: DownloadShotNoticias?) -> ShotNoticias? {
        var shotNoticias: ShotNoticias?
        if let myDictionary = dictionary {
            let model = ShotNoticias(identificadorUno: myDictionary.identificadorUno)
            shotNoticias = model
        }
        return shotNoticias
    }
}

enum NoticiasFavoritasProviderService {
    case portadaCatalunya
    case portadaValenciana
    case portadaAragon
    case portadaVasco
    case portadaGalicia
    case portadaMercados
}

extension NoticiasFavoritasProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHostNoticias
    }
    
    var path: String {
        switch self {
        case NoticiasFavoritasProviderService.portadaCatalunya:
            return Helpers.customUrl().portadaNoticiasCatalunia
        case NoticiasFavoritasProviderService.portadaValenciana:
            return Helpers.customUrl().portadaNoticiasValenciana
        case NoticiasFavoritasProviderService.portadaAragon:
            return Helpers.customUrl().portadaNoticiasAragon
        case NoticiasFavoritasProviderService.portadaVasco:
            return Helpers.customUrl().portadaNoticiasPaisVacsco
        case NoticiasFavoritasProviderService.portadaGalicia:
            return Helpers.customUrl().portadaNoticiasGalicia
        case NoticiasFavoritasProviderService.portadaMercados:
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
