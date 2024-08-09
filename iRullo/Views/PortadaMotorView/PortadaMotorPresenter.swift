//
//  PortadaMotorPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation


// Output
protocol PortadaMotorPresenterProtocol: BaseProviderOutputProtocol {
    func setPortadaMotor(completion: Result<[PortadaMotorModel]?, NetworkError>)
}


final class PortadaMotorPresenter: BaseViewModel, ObservableObject {
        
    var provider: PortadaMotorProviderInputProtocol? {
        super.baseProvider as? PortadaMotorProviderInputProtocol
    }
    
    @Published var portadasMotor: [PortadaMotorModel]?
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataPortadaMotor()
    }
}

extension PortadaMotorPresenter: PortadaMotorPresenterProtocol {
    
    func setPortadaMotor(completion: Result<[PortadaMotorModel]?, NetworkError>) {
        switch completion{
        case .success(let data):
            portadasMotor = data
        case .failure(let error):
            debugPrint(error)
        }
    }
}
