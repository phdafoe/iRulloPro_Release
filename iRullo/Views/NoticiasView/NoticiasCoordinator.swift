//
//  NoticiasCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import Foundation
import SwiftUI

final class NoticiasCoordinator: BaseCoordinator {
    
    typealias ContentView = NoticiasView
    typealias ViewModel = NoticiasPresenter
    typealias Provider = NoticiasProvider
    
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

