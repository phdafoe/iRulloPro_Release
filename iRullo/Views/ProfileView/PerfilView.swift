//
//  PerfilView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI
import UIKit



struct PerfilView: View {
    
    @StateObject private var viewModel = PerfilViewPresenter()
    @EnvironmentObject private var viewModelSession: LoginRegistroPresenter
    @ScaledMetric(relativeTo: .title2) private var trophySize: CGFloat = 100
    @State private var tipoAutentication: TipoAutenticacion
    
    init(tipoAutentication: TipoAutenticacion) {
        _tipoAutentication = State(initialValue: tipoAutentication)
    }
    @State private var isCustomAlert = false
    @State private var isTerminosCondiciones = false
    
    fileprivate func estaLogadoCorrectamente() -> some View {
        return VStack(spacing: 20) {
            Image(systemName: "trophy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: trophySize, height: trophySize)
                .accessibilityHidden(true)
            
            Text("Te damos las gracias por ser miembro de iRullo")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .accessibilityHeading(.h1)

            AccessibilityPreferencesSection()

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
                ScrollView {
                    estaLogadoCorrectamente()
                        .frame(maxWidth: 600)
                        .frame(maxWidth: .infinity)
                }
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

private struct AccessibilityPreferencesSection: View {
    @Environment(\.openURL) private var openURL
    @AppStorage("ACCESSIBILITY_LARGER_TEXT") private var prefersLargerText = false
    @AppStorage("ACCESSIBILITY_HIGH_CONTRAST") private var prefersHighContrast = false
    @AppStorage("ACCESSIBILITY_REDUCE_MOTION") private var prefersReducedMotion = false

    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 16) {
                accessibilityToggle(
                    title: "Texto más grande",
                    description: "Usa texto de tamaño accesible sin reducir el tamaño configurado en iOS.",
                    isOn: $prefersLargerText
                )

                Divider()

                accessibilityToggle(
                    title: "Contraste reforzado",
                    description: "Aumenta la diferencia visual entre el contenido y sus fondos.",
                    isOn: $prefersHighContrast
                )

                Divider()

                accessibilityToggle(
                    title: "Reducir movimiento",
                    description: "Desactiva las animaciones decorativas dentro de iRullo.",
                    isOn: $prefersReducedMotion
                )

                Divider()

                Text("VoiceOver y otros ajustes del sistema se administran en Ajustes > Accesibilidad.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Button(action: openAppSettings) {
                    Label("Abrir ajustes de iRullo", systemImage: "gear")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .accessibilityHint("Abre la página de ajustes de iRullo en la aplicación Ajustes")
            }
        } label: {
            Label("Accesibilidad", systemImage: "accessibility")
                .font(.headline)
                .accessibilityHeading(.h2)
        }
        .padding(.horizontal, 20)
    }

    private func accessibilityToggle(
        title: LocalizedStringKey,
        description: LocalizedStringKey,
        isOn: Binding<Bool>
    ) -> some View {
        Toggle(isOn: isOn) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body.weight(.semibold))
                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .toggleStyle(.switch)
    }

    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        openURL(settingsURL)
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
