//
//  PortadaBaloncestoCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import Foundation
import SwiftUI

final class PortadaBaloncestoCoordinator: BaseCoordinator {
    
    typealias ContentView = PortadaBaloncestoView
    typealias ViewModel = PortadaBaloncestoPresenter
    typealias Provider = PortadaBaloncestoProvider
    
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
