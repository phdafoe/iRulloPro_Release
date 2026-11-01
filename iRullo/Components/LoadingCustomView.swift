//
//  LoadingCustomView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 14/8/24.
//

import SwiftUI

@MainActor
final class NetworkActivityController: ObservableObject {
    static let shared = NetworkActivityController()

    @Published private(set) var activeRequestCount = 0

    var isLoading: Bool {
        activeRequestCount > 0
    }

    private init() {}

    func beginRequest() {
        activeRequestCount += 1
    }

    func endRequest() {
        activeRequestCount = max(0, activeRequestCount - 1)
    }
}

struct LoadingCustomView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.55)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .controlSize(.large)
                    .tint(.accentColor)

                Text("Cargando contenido")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 24)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
            .shadow(radius: 12)
            .frame(maxWidth: 320)
            .padding()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Cargando contenido")
        .accessibilityHint("Espera mientras se actualiza la información")
        .accessibilityAddTraits(.updatesFrequently)
        .zIndex(1)
    }
}

#Preview {
    LoadingCustomView()
}
