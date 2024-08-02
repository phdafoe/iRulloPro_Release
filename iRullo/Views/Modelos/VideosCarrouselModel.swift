//
//  VideosCarrouselModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import Foundation

struct ContentVideosCarrouselModel: Identifiable {
    var id = UUID()
    let contentVideoModel: [ContentVideosModel]?
}

struct ContentVideosModel: Identifiable {
    var id = UUID()
    let headlines: HeadLines?
    let contentData: [ContentVideoData]?
    let uri: String?
    
    var uriPathURL: URL {
        return URL(string: "\(uri ?? "")")!
    }
}

struct ContentVideoData {
    let elementosModel: [ElementosModel]?
}
