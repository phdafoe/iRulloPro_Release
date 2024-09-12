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
        let hostNoticias = "api.elconfidencial.com"
        let apiHost = "https://cntapiapp.prisasd.com/app/"
        let apiHostNoticias = "https://api.elconfidencial.com/service/"
        let apiHostHeroku = "https://icospartan-app.herokuapp.com/"
        
        
        let portada = "pages/as/site/as.com/portada"
        let videosPortada = "list/as/site/as.com/section/videos/subsection/top-de-astv/"
        let portadaFutbol = "pages/as/site/as.com/section/futbol/portada"
        let portadasBaloncesto = "pages/as/site/as.com/section/baloncesto/portada"
        let portadasMotor = "pages/as/site/as.com/section/motor/portada"
        let portadasTenis = "pages/as/site/as.com/section/tenis/portada"
        let portadasCiclismo = "pages/as/site/as.com/section/ciclismo/portada"
        let portadasMasDeporte = "pages/as/site/as.com/section/masdeporte/portada"
        
        let portadasMasDeporteSubsectionAtletismo = "pages/as/site/as.com/section/masdeporte/subsection/atletismo"
        
        let portadaNoticiasHome = "home/frontp/1/0/"
        let portadaNoticiasHomeNotificacion = "home/ticker/1"
        let portadaNoticiasMadrid = "content/espana/madrid/1/0/20/"
        let portadaNoticiasAndalucia = "content/espana/andalucia/1/0/20"
        
        let portadaNoticiasCatalunia = "content/espana/cataluna/1/0/20/"
        let portadaNoticiasValenciana = "content/espana/comunidad-valenciana/1/0/20/"
        let portadaNoticiasAragon = "content/espana/aragon/1/0/20/"
        let portadaNoticiasPaisVacsco = "content/espana/pais-vasco/1/0/20/"
        let portadaNoticiasGalicia = "content/espana/galicia/1/0/20/"
        let portadaNoticiasMercados = "content/mercados/the-wall-street-journal/1/0/20/"
        
        let terminosYCondiciones = "iCoResponseTerminosCondiciones"
        
        
    }
    
    struct customKeys {
        let apiKey = "AIzaSyAnBzpN7FsYTtarghVZlu5K0yLx2pXL9dY"
        let authHeroku = "Bearer 123456789"
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


extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: ".json") else { return nil }
        let data = try Data(contentsOf: url)
        let decodeModel = try JSONDecoder().decode(D.self, from: data)
        return decodeModel
    }
}
