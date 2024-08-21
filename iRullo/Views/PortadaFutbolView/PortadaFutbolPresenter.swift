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
}


final class PortadaFutbolPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaFutbolProviderInputProtocol? {
        super.baseProvider as? PortadaFutbolProviderInputProtocol
    }
    
    @Published var portadasFutbol: [PortadaFutbolModel]?
    @Published var portadasNoticiaDestacada: NoticiasNotificacionModel?
    @Published var portadasNoticiaDestacadaHtmlString: String?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaFutbol()
        self.provider?.fecthDataPortadaNoticiasNotificacion()
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
    
    func setPortadaNoticiasNotificacion(completion: Result<NoticiasNotificacionModel?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            portadasNoticiaDestacada = data
            data?.data?.first?.transformData(completionHandler: { myHtmlString in
                debugPrint(myHtmlString ?? "AQUI ANDRES")
                self.portadasNoticiaDestacadaHtmlString = myHtmlString
            })
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
