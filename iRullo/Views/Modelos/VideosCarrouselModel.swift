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
}

struct ContentVideoData {
    let elementosModel: [ElementosModel]?
}
