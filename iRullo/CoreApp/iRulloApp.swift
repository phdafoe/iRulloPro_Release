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
    @StateObject private var networkActivity = NetworkActivityController.shared
    @StateObject private var session = LoginRegistroPresenter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AccessibilityPreferencesView {
                    MainView()
                        .environmentObject(session)
                }
                .accessibilityHidden(networkActivity.isLoading)

                if networkActivity.isLoading {
                    LoadingCustomView()
                }
            }
        }
    }
}
