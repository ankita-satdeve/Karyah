//
//  DashboardView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack {
            Text("🏠 Welcome to Dashboard!")
                .font(.largeTitle)

            Button("Logout") {
                authManager.logout()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(AuthManager()) // Inject the AuthManager
            .previewDevice("iPhone 14 Pro")
    }
}
