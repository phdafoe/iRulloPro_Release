//
//  PortadaMasDeportePresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation


// Output
protocol PortadaMasDeportePresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaMasDeporte(completion: Result<[PortadaMasDeporteModel]?, NetworkError>)
}


final class PortadaMasDeportePresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaMasDeporteProviderInputProtocol? {
        super.baseProvider as? PortadaMasDeporteProviderInputProtocol
    }
    
    @Published var portadasMasDeporte: [PortadaMasDeporteModel]?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaMasDeporte()
    }
}

extension PortadaMasDeportePresenter: PortadaMasDeportePresenterProtocol {
    
    func setPortadaMasDeporte(completion: Result<[PortadaMasDeporteModel]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasMasDeporte = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
