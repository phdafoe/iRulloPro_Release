//
//  SwiftUIView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("LOGADO") private var logado: Bool = false
    
    var body: some View {
        
        if currentPage > totalPages && logado {
            HomeView()
        } else {
            WalkthroughtView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#Preview {
    MainView()
}
