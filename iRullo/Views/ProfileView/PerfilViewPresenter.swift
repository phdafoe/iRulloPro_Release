//
//  PerfilViewPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 14/8/24.
//

import Foundation
import FirebaseAuth


final class PerfilViewPresenter: ObservableObject {
    
    private let authenticationData = Auth.auth()
    
    var provider: PerfilViewProviderInputProtocol = PerfilViewProvider()
    
    @Published var terminosYCondiciones: String = ""
    @Published var error: NSError?

    func terminos() -> String {
        self.provider.fecthDataTerminosCondiciones { terminos in
            if let terminosUnw = terminos {
                self.terminosYCondiciones = terminosUnw
            }
        }
        return self.terminosYCondiciones
    }
    
    
    // Logout
    func desconectarSesion() {
        do {
            try authenticationData.signOut()
            UserDefaults.standard.set(false, forKey: "LOGADO")
        } catch {
            self.error = NSError(domain: "", code: 9999, userInfo: [NSLocalizedDescriptionKey : "El usuario no ha logrado desconectar la sesion"])
        }
    }

}
