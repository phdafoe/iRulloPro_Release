//
//  PortadaMercadosPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/9/24.
//

import Foundation


// Output
protocol PortadaMercadosPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadasMercados(completion: Result<[NoticiasData]?, NetworkError>)
    func setPortadasEconomia(completion: Result<[NoticiasData]?, NetworkError>)
    func setPortadasEmpresas(completion: Result<[NoticiasData]?, NetworkError>)
    func setPortadasVivienda(completion: Result<[NoticiasData]?, NetworkError>)
}


final class PortadaMercadosPresenter: BaseViewModel, ObservableObject {
    
    var provider: PortadaMercadosProviderInputProtocol? {
        super.baseProvider as? PortadaMercadosProviderInputProtocol
    }
    
    @Published var portadasMercados: [NoticiasData]?
    @Published var portadasEmpresas: [NoticiasData]?
    @Published var portadasEconomia: [NoticiasData]?
    @Published var portadasVivienda: [NoticiasData]?
    
    
    func fetchDataPortadaMercados () {
        self.provider?.fecthDataPortadaMercados()
    }
    
    func fetchDataPortadaEmpresas () {
        self.provider?.fecthDataPortadaEmpresas()
    }
    
    func fetchDataPortadaEconomia () {
        self.provider?.fecthDataPortadaEconomia()
    }
    
    func fetchDataPortadaVivienda() {
        self.provider?.fecthDataPortadaVivienda()
    }
    
}

extension PortadaMercadosPresenter: PortadaMercadosPresenterProtocol {
    func setPortadasMercados(completion: Result<[NoticiasData]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasMercados = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadasEconomia(completion: Result<[NoticiasData]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasEconomia = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadasEmpresas(completion: Result<[NoticiasData]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasEmpresas = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadasVivienda(completion: Result<[NoticiasData]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasVivienda = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    
}
