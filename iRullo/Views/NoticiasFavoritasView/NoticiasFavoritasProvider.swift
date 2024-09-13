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
