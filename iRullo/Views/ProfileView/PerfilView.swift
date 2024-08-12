//
//  PerfilView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI
import AuthenticationServices


struct PerfilView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginFailed: Bool = false
    
    
    @State private var fullName: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswordMismatchAlert: Bool = false
    
    @State private var isRegister: Bool = false
    
    var body: some View {
        
        if !isRegister{
            VStack(spacing: 20) {
                Text("Iniciar Sesión")
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
                    authenticateUser()
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
                
                // Botón para iniciar sesión
                Button(action: {
                    isRegister.toggle()
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
        } else {
            VStack(spacing: 20) {
                Text("Crear Cuenta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Campo de texto para el nombre completo
                TextField("Nombre Completo", text: $fullName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.words)
                    .padding(.horizontal, 20)
                
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
                
                // Campo de texto para confirmar la contraseña
                SecureField("Confirmar Contraseña", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                
                // Botón para registrarse
                Button(action: {
                    registerUser()
                }) {
                    Text("Registrarse")
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
                    isRegister.toggle()
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
                            // Configurar el request si es necesario (por ejemplo, solicitar nombre o email)
                            request.requestedScopes = [.fullName, .email]
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
        }
        
    }
    
    // Función que simula la autenticación del usuario
    func authenticateUser() {
        // Aquí puedes agregar la lógica de autenticación, por ejemplo, verificar contra un servidor
        if email.lowercased() == "usuario@correo.com" && password == "password123" {
            // Autenticación exitosa
            isLoginFailed = false
            print("Inicio de sesión exitoso")
        } else {
            // Autenticación fallida
            isLoginFailed = true
        }
    }
    
    // Función que simula el registro de usuario
    func registerUser() {
        // Validar que las contraseñas coincidan
        guard password == confirmPassword else {
            showPasswordMismatchAlert = true
            return
        }
        
        // Aquí puedes agregar la lógica para registrar el usuario, como enviar los datos a un servidor.
        print("Usuario registrado con éxito")
        print("Nombre Completo: \(fullName)")
        print("Correo Electrónico: \(email)")
        print("Contraseña: \(password)")
    }
    
    func handleAuthorization(authResults: ASAuthorization) {
        // Manejar los resultados de la autorización
        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let email = appleIDCredential.email
            let fullName = appleIDCredential.fullName
            
            // Puedes almacenar el userID para futuras autenticaciones
            print("ID de usuario: \(userID)")
            print("Email: \(email ?? "No disponible")")
            print("Nombre completo: \(fullName?.givenName ?? "No disponible") \(fullName?.familyName ?? "")")
            
            // Aquí podrías enviar los datos al backend para registrar el usuario
            self.isRegister = true
        }
    }

}

#Preview {
    PerfilView()
}
