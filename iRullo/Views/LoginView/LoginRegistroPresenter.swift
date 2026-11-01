//
//  LoginRegistroPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/9/24.
//

import Foundation
import CryptoKit
import FirebaseAuth


enum LoginOption {
    case inicioSesionConApple(idTokenString: String, nonceDes: String)
    case emailAndPassword(email: String, password: String)
}

enum TipoAutenticacion: String {
    case sigin
    case signup
    
    var text: String {
        switch self {
        case .sigin :
            return "Iniciar Sesión".capitalized
        case .signup :
            return "Crear Cuenta".capitalized
        }
    }
    
    var footerText: String {
        switch self {
        case .sigin:
            return "No eres miembro aún, Registrate"
        case .signup:
            return "Listo para ser parte de iRullo?"
        }
    }
}

final class LoginRegistroPresenter: ObservableObject {
    
    @Published var usuarioLogado: User?
    @Published var cambioPassword: Bool?
    @Published var usuarioAutenticado = false
    @Published var error: NSError?
    @Published var currentNonce:String?
    
    private let authenticationData = Auth.auth()
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    required init() {
        usuarioLogado = authenticationData.currentUser
        usuarioAutenticado = usuarioLogado != nil
        UserDefaults.standard.set(usuarioAutenticado, forKey: "LOGADO")
        authStateDidChangeListenerHandle = authenticationData.addStateDidChangeListener(estadoDeAutenticacionModificado)
    }
    
    deinit {
        if let authStateDidChangeListenerHandle {
            authenticationData.removeStateDidChangeListener(authStateDidChangeListenerHandle)
        }
    }
    
    private func estadoDeAutenticacionModificado(with auth: Auth, user: User?) {
        usuarioLogado = user
        usuarioAutenticado = user != nil
        UserDefaults.standard.set(usuarioAutenticado, forKey: "LOGADO")
    }
    
    // Login
    func acceso(with loginOption: LoginOption) {
        error = nil
        switch loginOption {
        case let .inicioSesionConApple(idTokenString, nonceDes):
            let credential = OAuthProvider.credential(
                providerID: AuthProviderID(rawValue: "apple.com") ?? AuthProviderID.apple,
                idToken: idTokenString,
                rawNonce: nonceDes
            )
            authenticationData.signIn(
                with: credential,
                completion: manejadorFoinalizacionDelResultadoDeAutenticacion
            )
        case let .emailAndPassword(email, password):
            authenticationData.signIn(
                withEmail: email,
                password: password,
                completion: manejadorFoinalizacionDelResultadoDeAutenticacion
            )
        }
    }
    
    // Registro
    func registro(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey : "La password y la confirmacion no son iguales"])
            return
        }
        error = nil
        authenticationData.createUser(
            withEmail: email,
            password: password,
            completion: manejadorFoinalizacionDelResultadoDeAutenticacion
        )
    }
    
    // Logout
    func desconectarSesion() {
        do {
            try authenticationData.signOut()
            usuarioLogado = nil
            usuarioAutenticado = false
            UserDefaults.standard.set(false, forKey: "LOGADO")
        } catch {
            self.error = NSError(domain: "", code: 9999, userInfo: [NSLocalizedDescriptionKey : "El usuario no ha logrado desconectar la sesion"])
        }
    }
    
    // Delete account
    func deleteAccountFirebase() {
        authenticationData.currentUser?.delete { [weak self] error in
            DispatchQueue.main.async {
                if let error {
                    self?.error = error as NSError
                } else {
                    self?.usuarioLogado = nil
                    self?.usuarioAutenticado = false
                    UserDefaults.standard.set(false, forKey: "LOGADO")
                }
            }
        }
    }
    
    // Callback
    private func manejadorFoinalizacionDelResultadoDeAutenticacion(with auth: AuthDataResult?, and error: Error?) {
        DispatchQueue.main.async {
            if let user = auth?.user {
                self.usuarioLogado = user
                self.usuarioAutenticado = true
                self.error = nil
                UserDefaults.standard.set(true, forKey: "LOGADO")
            } else if let error {
                self.usuarioAutenticado = false
                self.error = error as NSError
                UserDefaults.standard.set(false, forKey: "LOGADO")
            }
        }
    }
    
    func localUsuarioLogado() -> Bool {
        if UserDefaults.standard.bool(forKey: "LOGADO") {
            return true
        } else {
            return false
        }
    }
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
