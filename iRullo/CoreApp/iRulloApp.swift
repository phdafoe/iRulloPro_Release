//
//  iRulloApp.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/1/24.
//

import SwiftUI

@main
struct iRulloApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(LoginRegistroPresenter())
        }
    }
}
