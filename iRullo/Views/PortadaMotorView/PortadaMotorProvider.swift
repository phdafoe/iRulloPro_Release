//
//  PortadaMotorProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation

// Input
protocol PortadaMotorProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataPortadaMotor()
}

final class PortadaMotorProvider: BaseProvider {
    
    weak var viewModel: PortadaMotorPresenterProtocol? {
        super.baseViewModel as? PortadaMotorPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    
    func callBackPortadasMotor(dictionary: [[String: Any]]?) -> [PortadaMotorModel]? {
        let nuevoArray = dictionary?.dropFirst(2)
        let arrayPortadaFutbol: [PortadaMotorModel]? = nuevoArray?.compactMap {
            PortadaMotorModel(name: $0["name"] as? String,
                                   groups: callBackGroups(dictionary: $0["groups"] as? [[String: Any]] ?? []),
                                   additionalProperties: callBackAdditionalProperties(dictionary: $0["additionalProperties"] as? [String : Any]))
        }
        return arrayPortadaFutbol
    }
    
    func callBackGroups(dictionary: [[String: Any]]?) -> [GroupPortadas]? {
        let arrayGroups: [GroupPortadas]? = (dictionary?.compactMap {
            GroupPortadas(type: $0["type"] as? String,
                          contents: callBackContents(dictionary: $0["contents"] as? [[String : Any]] ?? []))
        })
        return arrayGroups
    }
    
    func callBackAdditionalProperties(dictionary: [String: Any]?) -> AdditionalPropertiesModel? {
        var additionalProperties: AdditionalPropertiesModel?
        if let myDictionary = dictionary {
            let model = AdditionalPropertiesModel(blockName: myDictionary["block"] as? String)
            additionalProperties = model
        }
        return additionalProperties
    }
    
    func callBackContents(dictionary: [[String: Any]]?) -> [ContentModel]? {
        let arrayContents: [ContentModel]? = dictionary?.compactMap {
            ContentModel(resourceURL: callBackResourceUrl(dictionary: $0["uri"] as? [String : Any]),
                         resourcePhotos: callBackResourcePhoto(dictionary: $0["resourcePhotos"] as? [[String : Any]]) ?? [],
                         genero: $0["genre"] as? String,
                         elementosModel: callBackElementosModel(dictionary: $0["elements"] as? [[String : Any]]),
                         headlines: callBackHeadlines(dictionary: $0["headlines"] as? [String : Any]))
            
        }
        return arrayContents
    }
    
    func callBackHeadlines(dictionary: [String: Any]?) -> HeadLines? {
        var headlines: HeadLines?
        if let myDictionary = dictionary {
            let model = HeadLines(kickerPortada: myDictionary["kicker"] as? String,
                                  titlePortada: myDictionary["title"] as? String,
                                  subtitlePortada: myDictionary["subtitle"] as? String,
                                  uriKicker: myDictionary["urikicker"] as? String)
            headlines = model
        }
        return headlines
    }
    
    func callBackElementosModel(dictionary: [[String: Any]]?) -> [ElementosModel]? {
        let arrayElementosModel: [ElementosModel]? = dictionary?.compactMap {
            ElementosModel(videoModel: callBackVideoModel(dictionary: $0["video"] as? [String: Any]),
                           elementType: $0["elementType"] as? String,
                           photo: callBackPhoto(dictionary: $0["photo"] as? [String: Any]))
        }
        return arrayElementosModel
    }
    
    func callBackResourceUrl(dictionary: [String: Any]?) -> ResourceURL? {
        var resourceUrl: ResourceURL?
        if let myDictionary = dictionary {
            let model = ResourceURL(uri: myDictionary["uri"] as? String)
            resourceUrl = model
        }
        return resourceUrl
    }
    
    func callBackResourcePhoto(dictionary: [[String: Any]]?) -> [ResourcePhotoModel]? {
        let arrayResourcePhoto: [ResourcePhotoModel]? = dictionary?.compactMap {
            ResourcePhotoModel(imageName: callBackImageModel(dictionary: $0["image"] as? [String : Any]),
                               titleControlMovil: $0["title"] as? String,
                               additionalPropertiesImage: callBackAdditionalPropertiesImage(dictionary: $0["additionalProperties"] as? [String : Any]),
                               showImageTrendingBar: true)
        }
        return arrayResourcePhoto
    }
    
    func callBackImageModel(dictionary: [String: Any]?) -> ImageModel? {
        var image: ImageModel?
        if let myDictionary = dictionary {
            let model = ImageModel(uriName: myDictionary["uri"] as? String)
            image = model
        }
        return image
    }
    
    func callBackAdditionalPropertiesImage(dictionary: [String: Any]?) -> AdditionalPropertiesImage? {
        var additionalPropertiesImage: AdditionalPropertiesImage?
        if let myDictionary = dictionary {
            let model = AdditionalPropertiesImage(channel: myDictionary["channel"] as? String,
                                                  showPlayButton: myDictionary["showPlayButton"] as? String)
            additionalPropertiesImage = model
        }
        return additionalPropertiesImage
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


extension PortadaMotorProvider: PortadaMotorProviderInputProtocol {
    
    func fecthDataPortadaMotor() {
        
        self.networkService.request(RequestModel(service: PortadaMotorProviderService.portadaMotor)) { myMotorDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadaMotor(completion: .failure(errorUnw))
            } else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadaMotor(completion: .success(self.callBackPortadasMotor(dictionary: myMotorDictionary?["areas"] as? [[String: Any]])))
                }
            }
        }
        
    }
}

enum PortadaMotorProviderService {
    case portadaMotor
}

extension PortadaMotorProviderService: Service {
    var baseURL: String {
        return Helpers.customUrl().apiHost
    }
    
    var path: String {
        return Helpers.customUrl().portadasMotor
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
