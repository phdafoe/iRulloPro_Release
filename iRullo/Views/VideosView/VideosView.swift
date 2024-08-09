//
//  VideosView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct VideosView: View {
    
    @StateObject var viewModel = VideosPresenter()
    @State var showProfileView = false
    
    fileprivate func videosView() -> some View {
        return VStack {
            ForEach(viewModel.videosPortadas ?? []) { index in
                PortadaVideoGenericoView(model: index)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                MainHeaderView(showProfileView: $showProfileView, tituloVista: "Videos")
                ScrollView(.vertical, showsIndicators: false){
                    videosView()
                }
            }.onAppear{
                Task {
                    await self.viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    VideosView()
}
