//
//  PortadaCiclismoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI

struct PortadaCiclismoView: View {
    
    @StateObject var viewModel = PortadaCiclismoPresenter()
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasCiclismo ?? []) { index in
                PortadaCiclismoTipoUno(contentData: index)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                MainHeaderView(showProfileView: $showProfileView, tituloVista: "Ciclismo")
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
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    PortadaCiclismoView()
}
