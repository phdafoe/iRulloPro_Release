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
        // URL de la página que quieres extraer
        if let url = URL(string: urlDestacado ?? "") {

            // Realiza la solicitud
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                // Manejo de errores
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                // Verifica que se haya recibido la data
                if let data = data, let htmlContent = String(data: data, encoding: .utf8) {
                    // Aquí tienes el HTML como String
                    print(htmlContent)
                    DispatchQueue.main.async {
                        completionHandler(htmlContent)
                    }
                } else {
                    print("Error al convertir la data en un String")
                }
            }
            // Inicia la tarea
            task.resume()
        }
    }
    
    
}
