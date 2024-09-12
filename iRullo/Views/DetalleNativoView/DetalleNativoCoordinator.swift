//
//  DetalleNativoCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/9/24.
//

import Foundation
import SwiftUI

final class DetalleNativoCoordinator: BaseCoordinator {
    
    typealias ContentView = DetalleNativoView
    typealias ViewModel = DetalleNativoPresenter
    typealias Provider = DetalleNativoProvider
    
    static func navigation(dto: DetalleNativoCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: DetalleNativoCoordinatorDTO? = nil) -> ContentView {
        let mvvm = BaseCoordinator.coordinator(viewModel: ViewModel.self, provider: Provider.self)
        mvvm.viewModel.noticiasData = dto?.data
        let view = ContentView(viewModel: mvvm.viewModel)
        return view
    }
}

struct DetalleNativoCoordinatorDTO {
    var data: NoticiasData?
}
