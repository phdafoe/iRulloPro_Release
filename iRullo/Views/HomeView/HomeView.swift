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
                        Image(systemName: item.imageName)
                        Text(item.title)
                    }
                    .tag(item.type)
            }
        }
        .accentColor(.yellow)
        .environment(\.colorScheme, .dark)
    }
    
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType{
        case .homePage:
            PortadaFutbolCoordinator.view()
        case .videos:
            VideosCoordinator.view()
        case .business:
            PortadaCoordinator.view()
        case .movies:
            PortadaCoordinator.view()
        case .technology:
            PortadaCoordinator.view()
        }
    }
}

#Preview {
    HomeView()
}
