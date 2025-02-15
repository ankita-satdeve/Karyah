//
//  ContentView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthManager()
    @State private var navigationPath = NavigationPath() // ✅ Declare navigationPath

    var body: some View {
        NavigationStack(path: $navigationPath) { // ✅ Wrap entire content inside NavigationStack
            switch authManager.currentScreen {
            case .splash:
                SplashView()
            case .otpView:
                OTPView()
                    .environmentObject(authManager)
            case .pinView:
                PINView()
                    .environmentObject(authManager)
            case .dashboard:
                DashboardView(navigationPath: $navigationPath) // ✅ Pass navigationPath as Binding
                    .environmentObject(authManager)
            }
        }
    }
}
