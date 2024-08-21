//
//  PortadaFutbolProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import Foundation

// Input
protocol PortadaFutbolProviderInputProtocol: BaseProviderInputProtocol {
    func fecthDataPortadaFutbol()
    func fecthDataPortadaNoticiasNotificacion()
    func fecthDataPortadaNoticiasMadrid()
}


final class PortadaFutbolProvider: BaseProvider {
    
    weak var viewModel: PortadaFutbolPresenterProtocol? {
        super.baseViewModel as? PortadaFutbolPresenterProtocol
    }
    let networkService: Requestable = NetworkRequestable()
    
    
    func callBackPortadasFutbol(dictionary: [[String: Any]]?) -> [PortadaFutbolModel]? {
        let nuevoArray = dictionary?.dropFirst(2)
        let arrayPortadaFutbol: [PortadaFutbolModel]? = nuevoArray?.compactMap {
            PortadaFutbolModel(name: $0["name"] as? String,
                               groups: callBackGroups(dictionary: $0["groups"] as? [[String: Any]] ?? []),
                               additionalProperties: callBackAdditionalProperties(dictionary: $0["additionalProperties"] as? [String : Any]))
        }
        return arrayPortadaFutbol
    }
    
    func callBackAdditionalProperties(dictionary: [String: Any]?) -> AdditionalPropertiesModel? {
        var additionalProperties: AdditionalPropertiesModel?
        if let myDictionary = dictionary {
            let model = AdditionalPropertiesModel(blockName: myDictionary["block"] as? String)
            additionalProperties = model
        }
        return additionalProperties
    }
    
    func callBackGroups(dictionary: [[String: Any]]?) -> [GroupPortadas]? {
        let arrayGroups: [GroupPortadas]? = (dictionary?.compactMap {
            GroupPortadas(type: $0["type"] as? String,
                          contents: callBackContents(dictionary: $0["contents"] as? [[String : Any]] ?? []))
        })
        return arrayGroups
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
    
    
    func callBackNoticiaDestacada(dictionary: [String: Any]?) -> NoticiasNotificacionModel? {
        var additionalProperties: NoticiasNotificacionModel?
        if let myDictionary = dictionary {
            let model = NoticiasNotificacionModel(data: callBackArrayNoticiaDestacado(dictionary: myDictionary["data"] as? [[String : Any]]))
            additionalProperties = model
        }
        return additionalProperties
    }
    
    func callBackArrayNoticiaDestacado(dictionary: [[String: Any]]?) -> [DataDestacado]? {
        let arrayDestacadoModel: [DataDestacado]? = dictionary?.compactMap {
            DataDestacado(titleDestacado: $0["title"] as? String,
                          urlDestacado: $0["url"] as? String,
                          caoptionDestacado: $0["caption"] as? String)
        }
        return arrayDestacadoModel
    }
    
    func callBackPortadasNoticiasMadrid(dictionary: [[String: Any]]?) -> [NoticiasData]? {
        let nuevoArray = dictionary
        let arrayPortadaNoticias: [NoticiasData]? = nuevoArray?.compactMap {
            NoticiasData(typenameNoticia: $0["typename"] as? String,
                         titleNoticia: $0["title"] as? String,
                         subtitleNoticia: $0["subtitle"] as? String,
                         leadingNoticia: $0["leadin"] as? String,
                         urlNoticia: $0["url"] as? String,
                         bodyNoticia: $0["body"] as? String,
                         shotsNoticia: callBackShotNoticias(dictionary: $0["shots"] as? [String : Any]))
        }
        return arrayPortadaNoticias
    }
    
    func callBackShotNoticias(dictionary: [String: Any]?) -> ShotNoticias? {
        var shotNoticias: ShotNoticias?
        if let myDictionary = dictionary {
            let model = ShotNoticias(identificadorUno: myDictionary["1"] as? String)
            shotNoticias = model
        }
        return shotNoticias
    }
    
    func paginate(array: [Any], page: Int, pageSize: Int) -> [Any] {
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, array.count)
        
        guard startIndex < array.count else {
            return []
        }
        
        return Array(array[startIndex..<endIndex])
    }
    
}

extension PortadaFutbolProvider: PortadaFutbolProviderInputProtocol {
    
    func fecthDataPortadaFutbol() {
        
        self.networkService.request(RequestModel(service: PortadaFutbolProviderService.portadaFutbol)) { myFutbolDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadaFutbol(completion: .failure(errorUnw))
            }else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadaFutbol(completion: .success(self.callBackPortadasFutbol(dictionary: myFutbolDictionary?["areas"] as? [[String: Any]])))
                }
            }
        }
    }
    
    func fecthDataPortadaNoticiasNotificacion() {
        
        self.networkService.request(RequestModel(service: PortadaFutbolProviderService.portadaNoticiasHomeNotificacion)) { myNoticiasNotificacionDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadaNoticiasNotificacion(completion: .failure(errorUnw))
            }else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadaNoticiasNotificacion(completion: .success(self.callBackNoticiaDestacada(dictionary: myNoticiasNotificacionDictionary)))
                }
            }
        }
    }
    
    func fecthDataPortadaNoticiasMadrid() {
        
        self.networkService.request(RequestModel(service: PortadaFutbolProviderService.portadaNoticiasHomeMadrid)) { myNoticiasMadridDictionary, error in
            if let errorUnw = error  {
                print(errorUnw)
                self.viewModel?.setPortadaNoticiasMadrid(completion: .failure(errorUnw))
            }else {
                DispatchQueue.main.async {
                    self.viewModel?.setPortadaNoticiasMadrid(completion: .success(self.callBackPortadasNoticiasMadrid(dictionary: myNoticiasMadridDictionary?["data"] as? [[String: Any]])))
                }
            }
        }
    }
}

enum PortadaFutbolProviderService {
    case portadaFutbol
    case portadaNoticiasHomeNotificacion
    case portadaNoticiasHomeMadrid
}

extension PortadaFutbolProviderService: Service {
    var baseURL: String {
        switch self {
        case PortadaFutbolProviderService.portadaFutbol:
            return Helpers.customUrl().apiHost
        case PortadaFutbolProviderService.portadaNoticiasHomeNotificacion, .portadaNoticiasHomeMadrid:
            return Helpers.customUrl().apiHostNoticias

        }
        
    }
    
    var path: String {
        switch self {
        case PortadaFutbolProviderService.portadaFutbol:
            return Helpers.customUrl().portadaFutbol
        case PortadaFutbolProviderService.portadaNoticiasHomeNotificacion:
            return Helpers.customUrl().portadaNoticiasHomeNotificacion
        case PortadaFutbolProviderService.portadaNoticiasHomeMadrid:
            return Helpers.customUrl().portadaNoticiasMadrid
        }
    }
    
    var parameter: [URLQueryItem]{
        return []
    }
    
    var headers: [String : String] {
        switch self {
        case PortadaFutbolProviderService.portadaFutbol:
            return [
                "Host": Helpers.customUrl().host,
                "Accept": "*/*",
                "x-api-key": Helpers.customKeys().apiKey,
                "device" : "iPhone9,3||iOS||\(Helpers.customDevice().systemVersion)",
                "User-Agent": "AS/\(Helpers.customDevice().systemVersion)(iOS)",
                "Accept-Language": "es"
            ]
        case PortadaFutbolProviderService.portadaNoticiasHomeNotificacion, .portadaNoticiasHomeMadrid:
            return [
                "Host": Helpers.customUrl().hostNoticias,
                "Accept": "*/*",
                "device" : "iPhone9,3||iOS||\(Helpers.customDevice().systemVersion)",
                "User-Agent": "AS/\(Helpers.customDevice().systemVersion)(iOS)",
                "Accept-Language": "es"
            ]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
