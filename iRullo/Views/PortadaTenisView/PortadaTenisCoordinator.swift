//
//  PortadaTenisCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/8/24.
//

import Foundation
import SwiftUI

final class PortadaTenisCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaTenisView
    typealias ViewModel = PortadaTenisPresenter
    typealias Provider = PortadaTenisProvider
    
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
