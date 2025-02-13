//
//  ContentView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthManager()

    var body: some View {
        switch authManager.currentScreen {
        case .splash:
            SplashView()
        case .otpView:
            OTPView().environmentObject(authManager) // here .env not there
        case .pinView:
            PINView().environmentObject(authManager)
        case .dashboard:
            DashboardView().environmentObject(authManager)
        }
    }
}
