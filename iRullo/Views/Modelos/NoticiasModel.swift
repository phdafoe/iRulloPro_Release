//
//  NoticiasModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import Foundation
import UIKit

struct NoticiasModel {
    let noticiasData: [NoticiasData]?
}

struct NoticiasData: Identifiable {
    var id = UUID()
    let typenameNoticia: String?
    let titleNoticia: String?
    let subtitleNoticia: String?
    let leadingNoticia: String?
    let urlNoticia: String?
    var bodyNoticia: String?
    let shotsNoticia: ShotNoticias?
    
    var urlPathURL: URL {
        return URL(string: "\(urlNoticia ?? "")")!
    }
    
    var cleanedText: String {
        return htmlToString(htmlText: bodyNoticia ?? "")
    }
    
    
    func htmlToString(htmlText: String) -> String {
        
        guard let data = htmlText.data(using: .utf8) else { return "" }
        
        // Convertimos el HTML a un NSAttributedString
        if let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil) {
            // Extraemos el texto plano
            return attributedString.string
        } else {
            return ""
        }
        
    }

}

struct ShotNoticias {
    let identificadorUno: String?
    
    var urlPathURL: URL {
        return URL(string: "\(identificadorUno ?? "")")!
    }
}

