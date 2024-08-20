//
//  PortadaFutbolView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import SwiftUI

struct PortadaFutbolView: View {
    
    @StateObject var viewModel = PortadaFutbolPresenter()
    @State var showProfileView = false
    @State private var showOptions = false
    @State private var isPresentingNoticias: Bool = false
    
    @AppStorage("LOGADO") private var logado: Bool = false
    @EnvironmentObject var viewModelSession: PerfilViewPresenter
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasFutbol ?? []) { index in
                PortadaTipoDos(contentData: index)
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            // Tu vista principal
            VStack{
                MainHeaderView(showProfileView: $showProfileView,
                               tituloVista: "Fútbol",
                               isFullScreen: .constant(false))
                ScrollView(.vertical, showsIndicators: false){
                    portadaView()
                }
                .refreshable {
                    await self.viewModel.fetchData()
                }
            }
            .onAppear{
                Task {
                    await self.viewModel.fetchData()
                }
            }
            
            // Muestra el spinner si `isLoading` es true
            if self.viewModel.isLoading {
                LoaderView()
            }
            
            if self.logado {
                
                            
                // Botón flotante y opciones
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // Opción 1
                        if showOptions {
                            Button(action: {
                                isPresentingNoticias.toggle()
                            }) {
                                Image(systemName: "newspaper.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                            .transition(.move(edge: .trailing)) // Animación al aparecer
                            .padding(.bottom, 70) // Espaciado entre botones
                            .fullScreenCover(isPresented: self.$isPresentingNoticias) {
                                //
                            } content: {
                                NoticiasCoordinator.view()
                                    .accentColor(.red)
                                    .environment(\.colorScheme, .dark)
                            }
                        }
                        
                        
                        // Botón flotante principal
                        Button(action: {
                            withAnimation {
                                showOptions.toggle()
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(showOptions ? 45 : 0))
                                .shadow(radius: 10)
                        }
                        .padding()
                    }
                }
                
            }
        }
    }
}

#Preview {
    PortadaFutbolView()
}
