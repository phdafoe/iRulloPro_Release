//
//  PerfilView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI
import AuthenticationServices


struct PerfilView: View {
    
    @EnvironmentObject var viewModelSession: PerfilViewPresenter
    @Environment(\.dismiss) var dismiss
    @State private var isSignedInWithApple = false
    
    @State var tipoAutentication: TipoAutenticacion
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginFailed: Bool = false
    
    
    @State private var fullName: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswordMismatchAlert: Bool = false
    
    @State private var login: Bool = false
    
    @State private var userIDApple: String = ""
    
    @AppStorage("LOGADO") private var logado: Bool = false
    
    var body: some View {
        
        ZStack{
            if logado {
                VStack(spacing: 20) {
                    Image(systemName: "flag.pattern.checkered")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Ya eres miembro de iRullo")
                    
                }
            } else if !viewModelSession.usuarioAutenticado && !login {
                VStack(spacing: 20) {
                    Text(tipoAutentication == .signup ? tipoAutentication.text : tipoAutentication.text)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 40)
                    
                    // Campo de texto para el correo electrónico
                    TextField("Correo Electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 20)
                    
                    // Campo de texto para la contraseña
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                    
                    if tipoAutentication == .signup {
                        // Campo de texto para confirmar la contraseña
                        SecureField("Confirmar Contraseña", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    
                    
                    // Botón para registrarse
                    Button(action: {
                        autenticationEmailPulsado()
                    }) {
                        Text(tipoAutentication == .signup ? tipoAutentication.text : tipoAutentication.text)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    .alert(isPresented: $showPasswordMismatchAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Las contraseñas no coinciden"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    // Botón para iniciar sesión
                    Button(action: {
                        login.toggle()
                        tipoAutentication = .sigin
                    }) {
                        Text("Iniciar Sesión")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    
                    VStack {
                        Text("Regístrate con Apple")
                            .font(.title)
                            .padding(.bottom, 20)
                        
                        SignInWithAppleButton(
                            .signIn,
                            onRequest: { request in
                                let nonce = self.viewModelSession.randomNonceString()
                                self.viewModelSession.currentNonce = nonce
                                request.requestedScopes = [.fullName, .email]
                                request.nonce = self.viewModelSession.sha256(nonce)
                            },
                            onCompletion: { result in
                                switch result {
                                case .success(let authResults):
                                    handleAuthorization(authResults: authResults)
                                case .failure(let error):
                                    print("Autenticación fallida: \(error.localizedDescription)")
                                }
                            }
                        )
                        .signInWithAppleButtonStyle(.black)
                        .frame(height: 50)
                        .padding(.horizontal, 20)
                    }
                }
                .padding()
            } else {
                VStack(spacing: 20) {
                    Text(login ? tipoAutentication.text : tipoAutentication.text)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Campo de texto para el email
                    TextField("Correo Electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 20)
                    
                    // Campo de texto para la contraseña
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                    
                    // Botón para iniciar sesión
                    Button(action: {
                        autenticationEmailPulsado()
                    }) {
                        Text(tipoAutentication.text)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    
                    // Botón para iniciar sesión
                    Button(action: {
                        login.toggle()
                        tipoAutentication = .signup
                    }) {
                        Text("Registrate")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    
                    // Mensaje de error en caso de fallo
                    if isLoginFailed {
                        Text("Email o contraseña incorrectos")
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                }
                .padding()
                
            }
            
        }
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
        .onAppear {
            checkAppleSignInStatus()
        }
        
    }
    
    private func autenticationEmailPulsado() {
        switch tipoAutentication {
        case .sigin:
            self.viewModelSession.acceso(with: .emailAndPassword(email: self.email.lowercased(), password: self.password))
            isLoginFailed = false
            print("Inicio de sesión exitoso")
            dismiss()
        case .signup:
            // Validar que las contraseñas coincidan
            guard password == confirmPassword else {
                showPasswordMismatchAlert = true
                return
            }
            self.viewModelSession.registro(email: self.email.lowercased(), password: self.password, passwordConfirmation: self.confirmPassword)
            // Aquí puedes agregar la lógica para registrar el usuario, como enviar los datos a un servidor.
            print("Usuario registrado con éxito")
            print("Correo Electrónico: \(email)")
            print("Contraseña: \(password)")
            dismiss()
        }
    }
    
    func handleAuthorization(authResults: ASAuthorization) {
        // Manejar los resultados de la autorización
        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let email = appleIDCredential.email
            let fullName = appleIDCredential.fullName
            
            self.userIDApple = userID
            
            
            // Puedes almacenar el userID para futuras autenticaciones
            print("ID de usuario: \(userID)")
            print("Email: \(email ?? "No disponible")")
            print("Nombre completo: \(fullName?.givenName ?? "No disponible") \(fullName?.familyName ?? "")")
            
            guard let nonce = self.viewModelSession.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            self.viewModelSession.acceso(with: .inicioSesionConApple(idTokenString: idTokenString, nonceDes: nonce))
            dismiss()
        }
    }
    
    func checkAppleSignInStatus() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: self.userIDApple) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // El usuario tiene una sesión válida
                DispatchQueue.main.async {
                    self.isSignedInWithApple = true
                }
            case .revoked, .notFound:
                // El usuario no ha iniciado sesión o la sesión ha sido revocada
                DispatchQueue.main.async {
                    self.isSignedInWithApple = false
                }
            default:
                break
            }
        }
    }
    
}
