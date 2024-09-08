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
        TabItemViewModel(imageName: "newspaper", title: "Mercados", type: .mercados),
        TabItemViewModel(imageName: "trophy", title: "Mas Deporte", type: .masdeporte),
        TabItemViewModel(imageName: "bookmark", title: "Mis Favoritos", type: .favoritos),
        TabItemViewModel(imageName: "person.circle", title: "Mi Perfil", type: .perfil)
    ]
}


struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType{
        case homePage
        case videos
        case mercados
        case perfil
        case masdeporte
        case favoritos
    }
}
