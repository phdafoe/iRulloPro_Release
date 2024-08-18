//
//  PortadaTenisPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import Foundation

// Output
protocol PortadaTenisPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaTenis(completion: Result<[PortadaTenisModel]?, NetworkError>)
}


final class PortadaTenisPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaTenisProviderInputProtocol? {
        super.baseProvider as? PortadaTenisProviderInputProtocol
    }
    
    @Published var portadasTenis: [PortadaTenisModel]?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaTenis()
    }
}

extension PortadaTenisPresenter: PortadaTenisPresenterProtocol {
    func setPortadaTenis(completion: Result<[PortadaTenisModel]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasTenis = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
