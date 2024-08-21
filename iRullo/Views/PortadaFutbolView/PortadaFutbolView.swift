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
            ForEach(viewModel.portadasFutbol ?? []) { index in
                PortadaTipoDos(contentData: index)
            }
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
            
            if self.viewModel.isLoading {
                LoaderView()
            }
        }
        .navigationTitle("Noticias destacadas")
    }
}

#Preview {
    PortadaFutbolView()
}
