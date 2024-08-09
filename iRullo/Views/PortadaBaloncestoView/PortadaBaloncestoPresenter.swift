//
//  PortadaBaloncestoPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation

// Output
protocol PortadaBaloncestoPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaBaloncesto(completion: Result<[PortadaBaloncestoModel]?, NetworkError>)
}


final class PortadaBaloncestoPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaBaloncestoProviderInputProtocol? {
        super.baseProvider as? PortadaBaloncestoProviderInputProtocol
    }
    
    @Published var portadasBaloncesto: [PortadaBaloncestoModel]?
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaBaloncesto()
    }
}

extension PortadaBaloncestoPresenter: PortadaBaloncestoPresenterProtocol {
    
    func setPortadaBaloncesto(completion: Result<[PortadaBaloncestoModel]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasBaloncesto = data
        case .failure(let error):
            debugPrint(error)
        }
    }
}
