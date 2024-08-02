//
//  VideosProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import Foundation

// Input
protocol VideosProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataVideos()
}


final class VideosProvider: BaseProvider {
    
    weak var viewModel: VideosPresenterProtocol? {
        super.baseViewModel as? VideosPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    
    func callBackVideos(dictionary: [[String: Any]]?) -> [ContentVideosModel]? {
        let arrayVideos: [ContentVideosModel]? = dictionary?.compactMap {
            ContentVideosModel(headlines: callBackHeadlines(dictionary: $0["headlines"] as? [String : Any]),
                               contentData: callBackContentModel(dictionary: $0["content"] as? [[String : Any]]), 
                               uri: $0["uri"] as? String)
        }
        return arrayVideos
    }
    
    func callBackHeadlines(dictionary: [String: Any]?) -> HeadLines? {
        var headlines: HeadLines?
        if let myDictionary = dictionary {
            let model = HeadLines(kickerPortada: myDictionary["kicker"] as? String,
                                  titlePortada: myDictionary["title"] as? String,
                                  subtitlePortada: myDictionary["subTitle"] as? String, 
                                  uriKicker: myDictionary["urikicker"] as? String)
            headlines = model
        }
        return headlines
    }
    
    func callBackContentModel(dictionary: [[String: Any]]?) -> [ContentVideoData]? {
        let arrayContentModel: [ContentVideoData]? = dictionary?.compactMap {
            ContentVideoData(elementosModel: callBackElementosModel(dictionary: $0["elements"] as? [[String : Any]]))
        }
        return arrayContentModel
    }
    
    func callBackElementosModel(dictionary: [[String: Any]]?) -> [ElementosModel]? {
        let arrayElementosModel: [ElementosModel]? = dictionary?.compactMap {
            ElementosModel(videoModel: callBackVideoModel(dictionary: $0["video"] as? [String: Any]),
                           elementType: $0["elementType"] as? String, 
                           photo: callBackPhoto(dictionary: $0["photo"] as? [String: Any]))
        }
        return arrayElementosModel
    }
    
    func callBackVideoModel(dictionary: [String: Any]?) -> VideoModel? {
        var videoModel: VideoModel?
        if let myDictionary = dictionary {
            let model = VideoModel(stillsVersions: callBackArrayImageModel(dictionary: myDictionary["stillVersions"] as? [[String : Any]]))
            videoModel = model
        }
        return videoModel
    }
    
    func callBackArrayImageModel(dictionary: [[String: Any]]?) -> [ImageModel]? {
        let arrayImageModel: [ImageModel]? = dictionary?.compactMap {
            ImageModel(uriName: $0["uri"] as? String)
        }
        return arrayImageModel
    }
    
    func callBackPhoto(dictionary: [String: Any]?) -> PhotoModel? {
        var photoModel: PhotoModel?
        if let myDictionary = dictionary {
            let model = PhotoModel(versions: callBackArrayImageModel(dictionary: myDictionary["versions"] as? [[String : Any]]))
            photoModel = model
        }
        return photoModel
    }
                               
   
    
    
}


extension VideosProvider: VideosProviderInputProtocol {
    
    func fecthDataVideos() {
        
        self.networkService.request(RequestModel(service: VideosProviderService.videos)) { myVideoDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setVideosHome(completion: .failure(errorUnw))
            }else {
                DispatchQueue.main.async {
                    self.viewModel?.setVideosHome(completion: .success(self.callBackVideos(dictionary: myVideoDictionary?["content"] as? [[String: Any]])))
                }
            }
        }
    }
}

enum VideosProviderService {
    case videos
}

extension VideosProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHost
    }
    
    var path: String {
        return Helpers.customUrl().videosPortada
    }
    
    var parameter: [URLQueryItem]{
        return []
    }
    
    var headers: [String : String] {
        let headerDict = [
            "Host": Helpers.customUrl().host,
            "Accept": "*/*",
            "x-api-key": Helpers.customKeys().apiKey,
            "device" : "iPhone9,3||iOS||\(Helpers.customDevice().systemVersion)",
            "User-Agent": "AS/\(Helpers.customDevice().systemVersion)(iOS)",
            "Accept-Language": "es"
        ]
        return headerDict
    }
    
    var method: HTTPMethod {
        return .get
    }
}
