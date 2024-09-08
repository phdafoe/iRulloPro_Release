//
//  GenericaNoticiasDestacadasPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/9/24.
//

import Foundation

// Output
protocol GenericaNoticiasDestacadasPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaGenerico(completion: Result<[NoticiasData]?, NetworkError>)
}


final class GenericaNoticiasDestacadasPresenter: BaseViewModel, ObservableObject {
        
    var provider: GenericaNoticiasDestacadasProviderInputProtocol? {
        super.baseProvider as? GenericaNoticiasDestacadasProviderInputProtocol
    }
    
    @Published var portadasGenerico: [NoticiasData]?
    
//    @MainActor
    func fetchDataPortadaGenericas (name: String) {
        self.provider?.fecthDataPortadaGenerico(name: name)        
    }
}

extension GenericaNoticiasDestacadasPresenter: GenericaNoticiasDestacadasPresenterProtocol {
    
    func setPortadaGenerico(completion: Result<[NoticiasData]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasGenerico = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    
}
