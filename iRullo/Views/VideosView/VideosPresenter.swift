//
//  VideosPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import Foundation

// Output
protocol VideosPresenterProtocol: BaseProviderOutputProtocol {
    func setVideosHome(completion: Result<[ContentVideosModel]?, NetworkError>)
}

final class VideosPresenter: BaseViewModel, ObservableObject {
        
    var provider: VideosProviderInputProtocol? {
        super.baseProvider as? VideosProviderInputProtocol
    }
    
    @Published var videosPortadas: [ContentVideosModel]?
    @Published var isLoading: Bool = false
    
    @MainActor
    func fetchData () async {
        self.provider?.fecthDataVideos()
    }
}

extension VideosPresenter: VideosPresenterProtocol {
    func setVideosHome(completion: Result<[ContentVideosModel]?, NetworkError>) {
        isLoading = true
        switch completion{
        case .success(let data):
            videosPortadas = data
            self.isLoading = false
        case .failure(let error):
            debugPrint(error)
        }
    }
}
