//
//  NoticiasFavoritasPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 11/9/24.
//

import Foundation

// Output
protocol NoticiasFavoritasPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaGenerico(completion: Result<[NoticiasData]?, NetworkError>)
}


final class NoticiasFavoritasPresenter: BaseViewModel, ObservableObject {
        
    var provider: NoticiasFavoritasProviderInputProtocol? {
        super.baseProvider as? NoticiasFavoritasProviderInputProtocol
    }
    
    @Published var portadasGenerico: [NoticiasData]?
    
    func fetchDataPortadaGenericas () {
        self.provider?.fecthDataPortadaFavoritas()
    }
}

extension NoticiasFavoritasPresenter: NoticiasFavoritasPresenterProtocol {
    
    func setPortadaGenerico(completion: Result<[NoticiasData]?, NetworkError>) {
        self.portadasGenerico?.removeAll()
        switch completion{
        case .success(let data):
            portadasGenerico = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    
}
