//
//  PortadaTenisView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import SwiftUI

struct PortadaTenisView: View {
    
    @StateObject var viewModel = PortadaTenisPresenter()
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasTenis ?? []) { index in
                PortadaTenisTipoUno(contentData: index)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    MainHeaderView(showProfileView: $showProfileView, tituloVista: "Tenis")
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
            }
        }
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    PortadaTenisView()
}
