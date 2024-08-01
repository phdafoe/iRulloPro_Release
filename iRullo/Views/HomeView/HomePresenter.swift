//
//  HomePresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import Foundation

final class HomePresenter: ObservableObject {
    
    @Published var selectedTabItem: TabItemViewModel.TabItemType = .homePage
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "house.circle.fill", title: "Portadas", type: .homePage),
        TabItemViewModel(imageName: "photo.artframe", title: "Videos", type: .videos),
        TabItemViewModel(imageName: "bahtsign.circle", title: "Business", type: .business),
        TabItemViewModel(imageName: "gear", title: "Technology", type: .movies),
        TabItemViewModel(imageName: "info.circle", title: "More", type: .technology)
        
    ]
}


struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType{
        case homePage
        case videos
        case business
        case movies
        case technology
    }
}
