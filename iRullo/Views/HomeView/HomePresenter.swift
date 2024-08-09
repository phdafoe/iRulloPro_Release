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
        TabItemViewModel(imageName: "house", title: "Portadas", type: .homePage),
        TabItemViewModel(imageName: "play.rectangle", title: "Videos", type: .videos),
        TabItemViewModel(imageName: "basketball", title: "Baloncesto", type: .baloncesto),
        TabItemViewModel(imageName: "car", title: "Motor", type: .motor),
        TabItemViewModel(imageName: "trophy", title: "Mas Deporte", type: .masdeporte)
        
    ]
}


struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType{
        case homePage
        case videos
        case baloncesto
        case motor
        case masdeporte
    }
}
