//
//  PortadaFutbolPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import Foundation

// Output
protocol PortadaFutbolPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaFutbol(completion: Result<[PortadaFutbolModel]?, NetworkError>)
}


final class PortadaFutbolPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaFutbolProviderInputProtocol? {
        super.baseProvider as? PortadaFutbolProviderInputProtocol
    }
    
    @Published var portadasFutbol: [PortadaFutbolModel]?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaFutbol()
    }
}

extension PortadaFutbolPresenter: PortadaFutbolPresenterProtocol {
    
    func setPortadaFutbol(completion: Result<[PortadaFutbolModel]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasFutbol = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
