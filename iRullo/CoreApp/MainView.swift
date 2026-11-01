//
//  SwiftUIView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("currentPage") private var currentPage = 1
    @EnvironmentObject private var session: LoginRegistroPresenter
    
    var body: some View {
        if session.usuarioAutenticado {
            HomeView()
        } else if currentPage > totalPages {
            LoginRegistroView(tipoAutentication: .signup, dismissOnSuccess: false)
        } else {
            WalkthroughtView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#Preview {
    MainView()
}
