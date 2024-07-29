//
//  Helpers.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import Foundation
import UIKit

struct Helpers {
    
    struct customUrl {
        let host = "cntapiapp.prisasd.com"
        let apiHost = "https://cntapiapp.prisasd.com/app/"
        let portada = "pages/as/site/as.com/portada"
        let videosPortada = "list/as/site/as.com/section/videos/subsection/top-de-astv/"
    }
    
    struct customKeys {
        let apiKey = "AIzaSyAnBzpN7FsYTtarghVZlu5K0yLx2pXL9dY"
    }
    
    struct customDevice {
        let systemVersion = UIDevice.current.systemVersion
    }
    
    
    struct httpVerbs {
        let get = "GET"
    }
    
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
}
