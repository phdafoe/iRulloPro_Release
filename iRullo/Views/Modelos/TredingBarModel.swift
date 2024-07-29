//
//  TredingBarModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 26/7/24.
//

import Foundation

struct AdditionalPropertiesModel {
    let blockName: String?
}

struct GroupPortadas {
    var id = UUID()
    let type: String?
    let contents: [ContentModel]?
}

struct ContentModel: Identifiable {
    var id = UUID()
    let resourceURL: ResourceURL?
    let resourcePhotos: [ResourcePhotoModel]
    let genero: String?
    let elementosModel: [ElementosModel]?
    let headlines: HeadLines?
}

struct ResourceURL {
    let uri: String?
    
    var uriPathURL: URL {
        return URL(string: "\(uri ?? "")")!
    }
}

struct ResourcePhotoModel {
    let imageName: ImageModel?
    let titleControlMovil: String? 
    let additionalPropertiesImage: AdditionalPropertiesImage?
    
    var showImageTrendingBar: Bool?
    
    mutating func showImageTrending () -> Bool {
        if ((titleControlMovil?.contains("Frontis app móvil vertical")) != nil){
            self.showImageTrendingBar = true
        }
        return self.showImageTrendingBar ?? false
    }
}

struct ImageModel {
    let uriName: String?
    
    var uriPathURL: URL {
        return URL(string: "\(uriName ?? "")")!
    }
}

struct AdditionalPropertiesImage {
    let channel: String?
    let showPlayButton: String?
}

struct ElementosModel {
    let videoModel: VideoModel?
    let elementType: String?
}

struct VideoModel {
    let stillsVersions: [ImageModel]?
}

struct HeadLines {
    let kickerPortada: String?
    let titlePortada: String?
    let subtitlePortada: String?
}


