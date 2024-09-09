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
    @State private var isPresentingBaloncesto = false
    @State private var isPresentingMotor = false
    
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasMasDeporte ?? []) { index in
                PortadaMasDeporteTipoDos(contentData: index)
            }
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
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
                
                // Opción 1
                if showOptions {
                    Button(action: {
                        withAnimation {
                            isPresentingCycle.toggle()
                        }
                    }) {
                        Image(systemName: "figure.outdoor.cycle")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                    
                    NavigationLink(
                        destination: PortadaCiclismoCoordinator.view(),
                        isActive: $isPresentingCycle
                    ) {
                        EmptyView()
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
                    .padding()
                    
                    
                    NavigationLink(
                        destination:  PortadaTenisCoordinator.view(),
                        isActive: $isPresentingTennis
                    ) {
                        EmptyView()
                    }
                }
                
                // Opción 3
                if showOptions {
                    Button(action: {
                        isPresentingBaloncesto.toggle()
                    }) {
                        Image(systemName: "basketball")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                    
                    NavigationLink(
                        destination:  PortadaBaloncestoCoordinator.view(),
                        isActive: $isPresentingBaloncesto
                    ) {
                        EmptyView()
                    }
                }
                
                // Opción 4
                if showOptions {
                    Button(action: {
                        withAnimation {
                            isPresentingMotor.toggle()
                        }
                    }) {
                        Image(systemName: "car")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                    
                    NavigationLink(
                        destination:  PortadaMotorCoordinator.view(),
                        isActive: $isPresentingMotor
                    ) {
                        EmptyView()
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
        .navigationTitle("Más Deportes")
        .onAppear{
            Task {
                await self.viewModel.fetchData()
            }
        }
    }
}

#Preview {
    PortadaMasDeporteView()
}
