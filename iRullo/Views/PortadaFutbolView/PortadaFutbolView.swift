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
        NavigationView{
            ZStack {
                // Tu vista principal
                VStack{
                    MainHeaderView(showProfileView: $showProfileView, tituloVista: "Fútbol")
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
                                    //isPresentingCycle.toggle()
                                }) {
                                    Image(systemName: "figure.outdoor.cycle")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                                .transition(.move(edge: .trailing)) // Animación al aparecer
                                .padding(.bottom, 70) // Espaciado entre botones
//                                .sheet(isPresented: $isPresentingCycle) {
//                                    PortadaCiclismoCoordinator.view()
//                                }
                            }
                            
                            // Opción 2
                            if showOptions {
                                Button(action: {
//                                    isPresentingTennis.toggle()
                                }) {
                                    Image(systemName: "figure.tennis")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                                .transition(.move(edge: .trailing)) // Animación al aparecer
                                .padding(.bottom, 140) // Espaciado entre botones
//                                .sheet(isPresented: $isPresentingTennis) {
//                                    PortadaTenisCoordinator.view()
//                                }
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
}

#Preview {
    PortadaFutbolView()
}
