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
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasFutbol ?? []) { index in
                PortadaTipoDos(contentData: index)
            }
        }
    }
    
    
    var body: some View {
        NavigationView{
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
        }
    }
}

#Preview {
    PortadaFutbolView()
}
