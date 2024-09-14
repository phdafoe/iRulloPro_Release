//
//  PerfilView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI



struct PerfilView: View {
    
    @StateObject var viewModel = PerfilViewPresenter()
    @EnvironmentObject var viewModelSession: LoginRegistroPresenter
    @Environment(\.dismiss) var dismiss
    @State var tipoAutentication: TipoAutenticacion
    @AppStorage("LOGADO") private var logado: Bool = false
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
            /*
            Button(action: {
                self.viewModelSession.desconectarSesion()
            }) {
                Text("Logout")
                    .contentTransition(.identity)
                    .foregroundStyle(.black)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.white, in: .capsule)
                    .padding(.horizontal, 20)
            }
            .font(.title3)
            
            Button(action: {
                self.isCustomAlert.toggle()
            }) {
                Text("Delete Account")
                    .contentTransition(.identity)
                    .foregroundStyle(.black)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.white, in: .capsule)
                    .padding(.horizontal, 20)
            }
            .font(.title3)
             */
            
            Button(action: {
                self.isTerminosCondiciones.toggle()
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
        ZStack{
            
            estaLogadoCorrectamente()
            
            if isCustomAlert {
                CustomAlertView(title: "Estas seguro?",
                                message: "Si quieres eliminar tu cuenta en iRullo, no es un problema, recuerda que puedes cuando tú quieras",
                                imageURL: nil,
                                hideAlert: self.$isCustomAlert, hide: { value in
                    if value{
                        self.viewModelSession.deleteAccountFirebase()
                    }
                })
            }
            
            if isTerminosCondiciones {
                CustomAlertView(title: "Términos y Condiciones Generales",
                                message: self.viewModel.terminos(),
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

