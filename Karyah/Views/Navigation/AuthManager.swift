//
//  AuthManager.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

class AuthManager: ObservableObject {
    @Published var currentScreen: AppScreen = .splash

    init() {
        checkAuthentication()
    }

    func checkAuthentication() {
        let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        let authToken = UserDefaults.standard.string(forKey: "authToken")
        let lastLoginDate = UserDefaults.standard.object(forKey: "lastLoginDate") as? Date ?? Date()

        if !isRegistered {
            currentScreen = .otpView
        } else if authToken == nil || hasSessionExpired(lastLoginDate: lastLoginDate) {
            currentScreen = .pinView
        } else {
            currentScreen = .dashboard
        }
    }

    func login(token: String) {
        UserDefaults.standard.setValue(token, forKey: "authToken")
        UserDefaults.standard.setValue(Date(), forKey: "lastLoginDate")
        currentScreen = .dashboard
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
        currentScreen = .pinView
    }

    private func hasSessionExpired(lastLoginDate: Date) -> Bool {
        let expirationDays = 30
        let expirationTime = TimeInterval(expirationDays * 24 * 60 * 60)
        return Date().timeIntervalSince(lastLoginDate) > expirationTime
    }
}

enum AppScreen {
    case splash, otpView, pinView, dashboard
}
