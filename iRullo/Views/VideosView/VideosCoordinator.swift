//
//  VideosCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import Foundation
import SwiftUI

final class VideosCoordinator: BaseCoordinator {
    
    typealias ContentView = VideosView
    typealias ViewModel = VideosPresenter
    typealias Provider = VideosProvider
    
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
