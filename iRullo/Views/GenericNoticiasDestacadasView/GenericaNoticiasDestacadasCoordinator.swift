//
//  GenericaNoticiasDestacadasCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/9/24.
//

import Foundation
import SwiftUI

final class GenericaNoticiasDestacadasCoordinator: BaseCoordinator {
    
    typealias ContentView = GenericaNoticiasDestacadasView
    typealias ViewModel = GenericaNoticiasDestacadasPresenter
    typealias Provider = GenericaNoticiasDestacadasProvider
    
    static func navigation(dto: GenericaNoticiasDestacadasCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: GenericaNoticiasDestacadasCoordinatorDTO? = nil) -> ContentView {
        let mvvm = BaseCoordinator.coordinator(viewModel: ViewModel.self, provider: Provider.self)
        let view = ContentView(viewModel: mvvm.viewModel, name: dto?.name ?? "")
        return view
    }
}

struct GenericaNoticiasDestacadasCoordinatorDTO {
    let name: String
}
