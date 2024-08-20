//
//  NoticiasPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import Foundation

// Output
protocol NoticiasPresenterProtocol: BaseProviderOutputProtocol {
    func setNoticias(completion: Result<[NoticiasData]?, NetworkError>)
}


final class NoticiasPresenter: BaseViewModel, ObservableObject {
        
    var provider: NoticiasProviderInputProtocol? {
        super.baseProvider as? NoticiasProviderInputProtocol
    }
    
    @Published var portadasNoticias: [NoticiasData]?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataNoticias()
    }
}

extension NoticiasPresenter: NoticiasPresenterProtocol {
    func setNoticias(completion: Result<[NoticiasData]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasNoticias = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
