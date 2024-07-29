//
//  PortadaViewModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import Foundation
import Combine


final class PortadaViewModel: ObservableObject {
    
    
    let customService: Requestable = NetworkRequestable()
    var cancellable: Set<AnyCancellable> = []
    
    @Published var portada: Portada?
    @Published var videosPortada: VideosPortada?
    
    func fetchPortada() {
        customService.request(RequestModel(service: <#T##any Service#>), model: Portada.self)
    }
    
    @MainActor
    func fetchVideosPortada() async -> VideosPortada? {
        videosPortada = await customService.requestGeneric(model: VideosPortada.self, customUrl: Helpers.customUrl().apiHost+Helpers.customUrl().videosPortada)
        return videosPortada
    }
    
}
