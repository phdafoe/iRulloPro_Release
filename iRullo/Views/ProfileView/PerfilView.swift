//
//  PerfilView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI



struct PerfilView: View {
    
    @StateObject private var viewModel = PerfilViewPresenter()
    @EnvironmentObject private var viewModelSession: LoginRegistroPresenter
    @State private var tipoAutentication: TipoAutenticacion
    
    init(tipoAutentication: TipoAutenticacion) {
        _tipoAutentication = State(initialValue: tipoAutentication)
    }
    @State private var isCustomAlert = false
    @State private var isTerminosCondiciones = false
    
    @State private var showHomeView = false
    
    fileprivate func estaLogadoCorrectamente() -> some View {
        return VStack(spacing: 20) {
            Image(systemName: "trophy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
            
            Text("Te damos las gracias por ser miembro de iRullo")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Button("Cerrar sesión") {
                viewModelSession.desconectarSesion()
            }
            .profileButtonStyle()
            
            Button("Eliminar cuenta") {
                isCustomAlert = true
            }
            .profileButtonStyle()
            
            Button(action: {
                viewModel.cargarTerminos()
                isTerminosCondiciones = true
            }) {
                Text("Términos y condiciones")
                    .contentTransition(.identity)
                    .foregroundStyle(.black)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.white, in: .capsule)
                    .padding(.horizontal, 20)
            }
            .font(.title3)
            
        }
        .padding(20)
        .font(.title3)
    }
    
    var body: some View {
        ZStack {
            if viewModelSession.usuarioAutenticado {
                estaLogadoCorrectamente()
            } else {
                LoginRegistroView(tipoAutentication: tipoAutentication, dismissOnSuccess: false)
            }
            
            if viewModelSession.usuarioAutenticado && isCustomAlert {
                CustomAlertView(title: "Estas seguro?",
                                message: "Si quieres eliminar tu cuenta en iRullo, no es un problema, recuerda que puedes cuando tú quieras",
                                imageURL: nil,
                                hideAlert: self.$isCustomAlert, hide: { value in
                    if value{
                        self.viewModelSession.deleteAccountFirebase()
                    }
                })
            }
            
            if viewModelSession.usuarioAutenticado && isTerminosCondiciones {
                CustomAlertView(title: "Términos y Condiciones Generales",
                                message: viewModel.terminosYCondiciones.isEmpty ? "Cargando…" : viewModel.terminosYCondiciones,
                                imageURL: nil,
                                hideAlert: self.$isTerminosCondiciones, hide: { value in
                    if value{
                        //                            self.viewModelSession.deleteAccountFirebase()
                    }
                })
            }
        }
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
    }
}

private extension View {
    func profileButtonStyle() -> some View {
        foregroundStyle(.black)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .background(.white, in: .capsule)
            .padding(.horizontal, 20)
            .font(.title3)
    }
}
