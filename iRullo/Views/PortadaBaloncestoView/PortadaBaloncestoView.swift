//
//  PortadasBaloncestoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import SwiftUI

struct PortadaBaloncestoView: View {
    
    @StateObject var viewModel = PortadaBaloncestoPresenter()
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasBaloncesto ?? []) { index in
                PortadaBaloncestoTipoUno(contentData: index)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                MainHeaderView(showProfileView: $showProfileView, tituloVista: "Baloncesto")
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
    PortadaBaloncestoView()
}
