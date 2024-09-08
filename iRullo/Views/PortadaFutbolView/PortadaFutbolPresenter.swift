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
    func setPortadaNoticiasNotificacion(completion: Result<NoticiasNotificacionModel?, NetworkError>)
    func setPortadaNoticiasMadrid(completion: Result<[NoticiasData]?, NetworkError>)
    func setPortadaNoticiasAndalucia(completion: Result<[NoticiasData]?, NetworkError>)
}


final class PortadaFutbolPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaFutbolProviderInputProtocol? {
        super.baseProvider as? PortadaFutbolProviderInputProtocol
    }
    
    @Published var portadasFutbol: [PortadaFutbolModel]?
    @Published var portadasNoticiaDestacada: NoticiasNotificacionModel?
    @Published var portadasNoticiaMadrid: [NoticiasData]?
    @Published var portadasNoticiaAndalucia: [NoticiasData]?
    @Published var portadasNoticiaDestacadaHtmlString: String?
    @Published var isLoading: Bool = false
    
//    @MainActor
    func fetchDataPortadaFutbol () {
        self.provider?.fecthDataPortadaFutbol()
    }
    
    func fetchDataPortadaNoticiasNotificacion () {
        self.provider?.fecthDataPortadaNoticiasNotificacion()
    }
    
    func fetchDataPortadaNoticiasMadrid () {
        self.provider?.fecthDataPortadaNoticiasMadrid()
    }
    
    func fetchDataPortadaNoticiasAndalucia () {
        self.provider?.fecthDataPortadaNoticiasAndalucia()
    }
}

extension PortadaFutbolPresenter: PortadaFutbolPresenterProtocol {
    
    func setPortadaFutbol(completion: Result<[PortadaFutbolModel]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            DispatchQueue.main.async {
                self.portadasFutbol = data
            }
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadaNoticiasNotificacion(completion: Result<NoticiasNotificacionModel?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasNoticiaDestacada = data
            DispatchQueue.main.async {
                data?.data?.first?.transformData(completionHandler: { myHtmlString in
                    self.portadasNoticiaDestacadaHtmlString = myHtmlString
                })
            }
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadaNoticiasMadrid(completion: Result<[NoticiasData]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasNoticiaMadrid = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setPortadaNoticiasAndalucia(completion: Result<[NoticiasData]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasNoticiaAndalucia = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
