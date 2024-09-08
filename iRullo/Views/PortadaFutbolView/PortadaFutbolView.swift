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
    
    @State private var isMenuVisible = false
    @State private var widthPercent: CGFloat = 0.9
    @State private var horizontalPadding: CGFloat = 20.0
    @State private var isPresentingCatalunya = false
    @State private var isPresentingComunidadValenciana = false
    @State private var isPresentingAragon = false
    @State private var isPresentingVasco = false
    @State private var isPresentingGalicia = false
    
    var urlwebView: URL?
    
    fileprivate func portadaView() -> some View {
        return VStack {
            HStack {
                Text("Destacados Fútbol")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Rectangle()
                    .fill(Color(UIColor.cyan).opacity(0.3))
                    .frame(width: 50, height: 5)
            }.padding(.bottom, 20)
            ForEach(viewModel.portadasFutbol ?? []) { index in
                PortadaTipoDos(contentData: index)
            }
        }
    }
    
    fileprivate func portadaViewAndalucia() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados de Andalucía",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasNoticiaAndalucia ?? [])
        }
    }
    
    fileprivate func portadaMadridView() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados de Madrid",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasNoticiaMadrid ?? [])
        }
    }
    
    fileprivate func portadaDestacado() -> some View {
        return VStack{
            if (self.viewModel.portadasNoticiaDestacada?.data?.first?.urlPathDestacado) != nil {
                NavigationLink {
                    DetalleNativoDosView(data: self.viewModel.portadasNoticiaDestacadaHtmlString)
                } label: {
                    VStack(alignment: .leading){
                        Text(self.viewModel.portadasNoticiaDestacada?.data?.first?.caoptionDestacado ?? "")
                            .font(.title)
                        Text(self.viewModel.portadasNoticiaDestacada?.data?.first?.titleDestacado ?? "")
                            .font(.caption)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }.padding(.bottom)
    }
    
    fileprivate func opcionesMenu() -> GeometryReader<some View> {
        return GeometryReader { geo in
            HStack{
                VStack(alignment: .leading) {
                    
                    //Cataluña
                    Button {
                        isMenuVisible.toggle()
                        isPresentingCatalunya.toggle()
                    } label: {
                        HStack{
                            Text("Destacados Cataluña")
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                    }.padding()
                    
                    NavigationLink(
                        destination: GenericaNoticiasDestacadasCoordinator.view(dto: GenericaNoticiasDestacadasCoordinatorDTO.init(name: "Cataluna")),
                        isActive: $isPresentingCatalunya
                    ) {
                        EmptyView()
                    }
                    
                    //Valenciana
                    Button {
                        isMenuVisible.toggle()
                        isPresentingComunidadValenciana.toggle()
                    } label: {
                        HStack{
                            Text("Destacados Comunidad Valenciana")
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                    }.padding()
                    
                    NavigationLink(
                        destination: GenericaNoticiasDestacadasCoordinator.view(dto: GenericaNoticiasDestacadasCoordinatorDTO.init(name: "Valenciana")),
                        isActive: $isPresentingComunidadValenciana
                    ) {
                        EmptyView()
                    }
                    
                    //Aragon
                    Button {
                        isMenuVisible.toggle()
                        isPresentingAragon.toggle()
                    } label: {
                        HStack{
                            Text("Destacados Aragon")
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                    }.padding()
                    
                    NavigationLink(
                        destination: GenericaNoticiasDestacadasCoordinator.view(dto: GenericaNoticiasDestacadasCoordinatorDTO.init(name: "Aragon")),
                        isActive: $isPresentingAragon
                    ) {
                        EmptyView()
                    }
                    
                    //Vasco
                    Button {
                        isMenuVisible.toggle()
                        isPresentingVasco.toggle()
                    } label: {
                        HStack{
                            Text("Destacados Pais Vasco")
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                    }.padding()
                    
                    NavigationLink(
                        destination: GenericaNoticiasDestacadasCoordinator.view(dto: GenericaNoticiasDestacadasCoordinatorDTO.init(name: "Vasco")),
                        isActive: $isPresentingVasco
                    ) {
                        EmptyView()
                    }
                    
                    //Galicia
                    Button {
                        isMenuVisible.toggle()
                        isPresentingGalicia.toggle()
                    } label: {
                        HStack{
                            Text("Destacados Galicia")
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                    }.padding()
                    
                    NavigationLink(
                        destination: GenericaNoticiasDestacadasCoordinator.view(dto: GenericaNoticiasDestacadasCoordinatorDTO.init(name: "Galicia")),
                        isActive: $isPresentingGalicia
                    ) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width * widthPercent + (horizontalPadding * 2))
                .background(Color.black)
                .offset(x: isMenuVisible ? 0 : -((geo.size.width * widthPercent + (horizontalPadding * 2))))
                .animation(.easeInOut(duration: 0.3), value: isMenuVisible)
            }
            
        }
        
    }
    
    var body: some View {
        ZStack {
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    portadaDestacado()
                    portadaMadridView()
                    portadaViewAndalucia()
                    portadaView()
                }
                .refreshable {
                    self.viewModel.fetchDataPortadaFutbol()
                    self.viewModel.fetchDataPortadaNoticiasNotificacion()
                    self.viewModel.fetchDataPortadaNoticiasMadrid()
                    self.viewModel.fetchDataPortadaNoticiasAndalucia()
                }
            }
            .onAppear{
                self.viewModel.fetchDataPortadaFutbol()
                self.viewModel.fetchDataPortadaNoticiasNotificacion()
                self.viewModel.fetchDataPortadaNoticiasMadrid()
                self.viewModel.fetchDataPortadaNoticiasAndalucia()
            }
            
            // Menú deslizable
            if isMenuVisible {
                Color.black.opacity(0.7) // Fondo semitransparente
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isMenuVisible.toggle()
                        }
                    }
            }
            
            opcionesMenu()
            
        }
        .navigationBarItems(leading:
            HStack {
                Button(action: {
                    self.isMenuVisible.toggle()
                }) {
                    
                    Image(systemName: self.isMenuVisible ? "chevron.left": "list.triangle")
                        .foregroundColor(.red)
                }
            }
        )
        
    }
}

#Preview {
    PortadaFutbolView()
}
