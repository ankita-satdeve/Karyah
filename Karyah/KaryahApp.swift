//
//  KaryahApp.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

@main
struct KaryahApp: App {
    @StateObject var authManager = AuthManager() // Ensure it's a single instance
    var body: some Scene {
        WindowGroup {
            
//            ProjectDetailView()
            
              ProjectListView()
            
//            PINView()
//            ProfileView()
            
//            ManageConnectionView()
//            
//            ContentView()
//                .environmentObject(authManager) // Inject it here, now  all child views (including DashboardView) will have access to authManager.
//           
        }
    }
}
