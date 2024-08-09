//
//  PortadaMasDeporteCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation
import SwiftUI

final class PortadaMasDeporteCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaMasDeporteView
    typealias ViewModel = PortadaMasDeportePresenter
    typealias Provider = PortadaMasDeporteProvider
    
    static func navigation() -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view() -> ContentView {
        let mvvm = BaseCoordinator.coordinator(viewModel: ViewModel.self, provider: Provider.self)
        let view = ContentView(viewModel: mvvm.viewModel)
        return view
    }
}
