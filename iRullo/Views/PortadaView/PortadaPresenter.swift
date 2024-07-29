//
//  PortadaViewModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import Foundation

// Output
protocol PortadaPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadasHome(completion: Result<[AreaPortadas]?, NetworkError>)
}


final class PortadaPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaProviderInputProtocol? {
        super.baseProvider as? PortadaProviderInputProtocol
    }
    
    @Published var areasPortadas: [AreaPortadas]?
    
    @MainActor
    func fetchData () async {
        self.provider?.fetchDataPortadas()
    }
}

extension PortadaPresenter: PortadaPresenterProtocol {
    func setPortadasHome(completion: Result<[AreaPortadas]?, NetworkError>) {
        switch completion{
        case .success(let data):
            areasPortadas = data
        case .failure(let error):
            debugPrint(error)
        }
    }
}
