//
//  PerfilViewCoordinator.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/9/24.
//

import Foundation
import SwiftUI

final class PerfilViewCoordinator {
    
    typealias ContentView = PerfilView
    typealias ViewModel = PerfilViewPresenter
    typealias Provider = PerfilViewProvider
    
    static func navigation() -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view() -> ContentView {
        let view = ContentView(tipoAutentication: .signup)
        return view
    }
}
