//
//  LoadingCustomView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 14/8/24.
//

import SwiftUI

struct LoadingCustomView: View {
    var body: some View {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)  // Escala el spinner para que sea más grande
            }
        }
}

#Preview {
    LoadingCustomView()
}
