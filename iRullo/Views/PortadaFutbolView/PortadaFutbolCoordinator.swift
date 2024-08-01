//
//  PortadaFutbolCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import Foundation
import SwiftUI

final class PortadaFutbolCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaFutbolView
    typealias ViewModel = PortadaFutbolPresenter
    typealias Provider = PortadaFutbolProvider
    
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
