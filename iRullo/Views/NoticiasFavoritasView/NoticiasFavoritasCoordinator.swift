//
//  NoticiasFavoritasCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 11/9/24.
//

import Foundation
import SwiftUI

final class NoticiasFavoritasCoordinator: BaseCoordinator {
    
    typealias ContentView = NoticiasFavoritasView
    typealias ViewModel = NoticiasFavoritasPresenter
    typealias Provider = NoticiasFavoritasProvider
    
    static func navigation(dto: NoticiasFavoritasCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: NoticiasFavoritasCoordinatorDTO? = nil) -> ContentView {
        let mvvm = BaseCoordinator.coordinator(viewModel: ViewModel.self, provider: Provider.self)
        let view = ContentView(viewModel: mvvm.viewModel)
        return view
    }
}

struct NoticiasFavoritasCoordinatorDTO {
   
}
