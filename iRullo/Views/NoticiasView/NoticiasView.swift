//
//  NoticiasView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import SwiftUI

struct NoticiasView: View {
    
    @StateObject var viewModel = NoticiasPresenter()
    @State var showProfileView = false
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasNoticias ?? []) { index in
                PortadaNoticiasTipoDosView(contentData: index)
            }
        }
    }
    
    var body: some View {
        VStack{
            MainHeaderView(showProfileView: $showProfileView,
                           tituloVista: "Noticias",
                           isFullScreen: .constant(true))
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

#Preview {
    NoticiasView()
}
