//
//  PortadaCiclismoPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import Foundation

// Output
protocol PortadaCiclismoPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaCiclismo(completion: Result<[PortadaCiclismoModel]?, NetworkError>)
}


final class PortadaCiclismoPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaCiclismoProviderInputProtocol? {
        super.baseProvider as? PortadaCiclismoProviderInputProtocol
    }
    
    @Published var portadasCiclismo: [PortadaCiclismoModel]?
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaCiclismo()
    }
}

extension PortadaCiclismoPresenter: PortadaCiclismoPresenterProtocol {
    func setPortadaCiclismo(completion: Result<[PortadaCiclismoModel]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasCiclismo = data
        case .failure(let error):
            debugPrint(error)
        }
    }
}
