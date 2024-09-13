//
//  PortadaMercadosCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/9/24.
//

import Foundation
import SwiftUI

final class PortadaMercadosCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaMercadosView
    typealias ViewModel = PortadaMercadosPresenter
    typealias Provider = PortadaMercadosProvider
    
    static func navigation(dto: PortadaMercadosCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: PortadaMercadosCoordinatorDTO? = nil) -> ContentView {
        let mvvm = BaseCoordinator.coordinator(viewModel: ViewModel.self, provider: Provider.self)
        let view = ContentView(viewModel: mvvm.viewModel)
        return view
    }
}

struct PortadaMercadosCoordinatorDTO {
    
}
