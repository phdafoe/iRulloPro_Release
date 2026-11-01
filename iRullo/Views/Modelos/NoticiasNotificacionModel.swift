//
//  NoticiasNotificacionModel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 21/8/24.
//

import Foundation

struct NoticiasNotificacionModel {
    let data: [DataDestacado]?
}

struct DataDestacado {
    let titleDestacado: String?
    let urlDestacado: String?
    let caoptionDestacado: String?
    
    var urlPathDestacado: URL {
        return URL(string: "\(urlDestacado ?? "")")!
    }
    
    func transformData(completionHandler: @escaping (String?) -> ()) {
        guard let url = URL(string: urlDestacado ?? "") else {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            return
        }

        DispatchQueue.main.async {
            NetworkActivityController.shared.beginRequest()
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            let htmlContent = data.flatMap { String(data: $0, encoding: .utf8) }

            if let error {
                appLog(tag: .error, "Unable to load notification content: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                NetworkActivityController.shared.endRequest()
                completionHandler(htmlContent)
            }
        }
        .resume()
    }
    
    
}
