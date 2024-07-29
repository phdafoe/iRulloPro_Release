//
//  PortadaCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import Foundation
import SwiftUI

final class PortadaCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaView
    typealias ViewModel = PortadaPresenter
    typealias Provider = PortadaProvider
    
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
