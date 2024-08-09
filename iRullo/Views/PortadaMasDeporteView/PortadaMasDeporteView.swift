//
//  PortadaMasDeporteView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import SwiftUI

struct PortadaMasDeporteView: View {
    
    @StateObject var viewModel = PortadaMasDeportePresenter()
    @State private var showOptions = false
    @State private var isPresentingTennis = false
    @State private var isPresentingCycle = false
    
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasMasDeporte ?? []) { index in
                PortadaMasDeporteTipoDos(contentData: index)
            }
        }
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    MainHeaderView(showProfileView: $showProfileView, tituloVista: "Más Deporte")
                    ScrollView(.vertical, showsIndicators: false){
                        portadaView()
                    }
                    .refreshable {
                        await self.viewModel.fetchData()
                    }
                }
                
                // Botón flotante y opciones
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // Opción 1
                        if showOptions {
                            Button(action: {
                                isPresentingCycle.toggle()
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
                            .sheet(isPresented: $isPresentingCycle) {
                                PortadaFutbolCoordinator.view()
                            }
                        }
                        
                        // Opción 2
                        if showOptions {
                            Button(action: {
                                isPresentingTennis.toggle()
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
                            .sheet(isPresented: $isPresentingTennis) {
                                PortadaTenisCoordinator.view()
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
            .onAppear{
                Task {
                    await self.viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    PortadaMasDeporteView()
}
