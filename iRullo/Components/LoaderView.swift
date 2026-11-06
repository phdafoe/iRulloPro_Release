//
//  LoaderView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.35)

            ProgressView()
                .controlSize(.large)
                .tint(.white)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Cargando")
    }
}

#Preview {
    LoaderView()
}
