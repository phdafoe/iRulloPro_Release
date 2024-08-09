//
//  HomeView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomePresenter()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTabItem){
            ForEach(viewModel.tabItemViewModels, id: \.self) { item in
                tabView(for: item.type)
                    .tabItem {
                        Image(systemName: item.imageName).fontWeight(.light)
                        Text(item.title)
                    }
                    .tag(item.type)
            }
        }
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
    }
    
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType{
        case .homePage:
            PortadaFutbolCoordinator.view()
        case .videos:
            VideosCoordinator.view()
        case .baloncesto:
            PortadaBaloncestoCoordinator.view()
        case .motor:
            PortadaMotorCoordinator.view()
        case .masdeporte:
            PortadaMasDeporteCoordinator.view()
        }
    }
}

#Preview {
    HomeView()
}
