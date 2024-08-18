//
//  SwiftUIView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        if currentPage > totalPages {
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
