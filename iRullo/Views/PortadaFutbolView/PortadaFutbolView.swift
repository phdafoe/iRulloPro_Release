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
    
    fileprivate func portadaMadridView() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados de Madrid",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasNoticiaMadrid ?? [])
        }
    }
    
    fileprivate func portadaDestacado() -> some View {
        return VStack{
            if let urlUnw = self.viewModel.portadasNoticiaDestacada?.data?.first?.urlPathDestacado {
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

    var body: some View {
        ZStack {
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    portadaDestacado()
                    portadaView()
                    portadaMadridView()
                }
                .refreshable {
                    await self.viewModel.fetchDataPortadaFutbol()
                    await self.viewModel.fetchDataPortadaNoticiasNotificacion()
                    await self.viewModel.fetchDataPortadaNoticiasMadrid()
                }
            }
            .onAppear{
                Task {
                    await self.viewModel.fetchDataPortadaFutbol()
                    await self.viewModel.fetchDataPortadaNoticiasNotificacion()
                    await self.viewModel.fetchDataPortadaNoticiasMadrid()
                }
            }
            
//            if self.viewModel.isLoading {
//                LoaderView()
//            }
        }
        .navigationTitle("Noticias destacadas")
        .navigationBarItems(trailing:
                                HStack {
            Button(action: {
                print("Icono presionado")
            }) {
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)
            }
            Button(action: {
                print("Otro icono presionado")
            }) {
                Image(systemName: "gear")
                    .foregroundColor(.blue)
            }
        }
        )
    }
}

#Preview {
    PortadaFutbolView()
}
