//
//  PortadaMercadosView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/9/24.
//

import SwiftUI

struct PortadaMercadosView: View {
    
    @StateObject var viewModel = PortadaMercadosPresenter()
    
    
    fileprivate func portadaViewMercados() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados Mercado",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasMercados ?? [])
        }
    }
    
    fileprivate func portadaViewEconomia() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados Economía",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasEconomia ?? [])
        }
    }
    
    fileprivate func portadaViewEmpresas() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados Empresas",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasEmpresas ?? [])
        }
    }
    
    fileprivate func portadaViewVivienda() -> some View {
        return VStack {
            PortadaCarrousel(title: "Destacados Vivienda",
                             isPosterFromMoviesView: false,
                             noticias: self.viewModel.portadasVivienda ?? [])
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    portadaViewMercados()
                    portadaViewEconomia()
                    portadaViewEmpresas()
                    portadaViewVivienda()

                }
                .refreshable {
                    self.viewModel.fetchDataPortadaMercados()
                    self.viewModel.fetchDataPortadaEconomia()
                    self.viewModel.fetchDataPortadaEmpresas()
                    self.viewModel.fetchDataPortadaVivienda()
                }
            }
            .onAppear{
                self.viewModel.fetchDataPortadaMercados()
                self.viewModel.fetchDataPortadaEconomia()
                self.viewModel.fetchDataPortadaEmpresas()
                self.viewModel.fetchDataPortadaVivienda()
            }
            
        }
    }
}

#Preview {
    PortadaMercadosView()
}
