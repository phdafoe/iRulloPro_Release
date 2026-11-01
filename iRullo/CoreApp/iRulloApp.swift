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
    @ObservedObject private var networkActivity = NetworkActivityController.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AccessibilityPreferencesView {
                    MainView()
                        .environmentObject(LoginRegistroPresenter())
                }
                .accessibilityHidden(networkActivity.isLoading)

                if networkActivity.isLoading {
                    LoadingCustomView()
                }
            }
        }
    }
}
