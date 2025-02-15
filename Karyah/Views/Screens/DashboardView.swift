//
//  DashboardView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var dashboardViewModel = DashboardViewModel()
    @Binding var navigationPath: NavigationPath // ✅ Accept navigationPath as Binding
    
    
    var body: some View {
        ZStack {
                // Background color to match system theme
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Fixed Header
                    HeaderView(navigationPath: $navigationPath) // ✅ Pass navigationPath
                        .frame(height: 10) // Adjust height as needed
                        .background(Color.red) // Match header background
                        .zIndex(1) // Ensure it stays above the ScrollView
                    
                    // Scrollable Content
                    ScrollView {
                        VStack(spacing: 16) {
                                PieChartSection()
                                .padding(.vertical, 30)
                                .padding()
                            
                            ForEach(dashboardViewModel.issues) { issue in
                                CriticalIssueCard(issue: issue)
                            }
                            
                            TasksOverview(tasks: dashboardViewModel.tasks)
                            
                            Spacer(minLength: 100) // To prevent overlap
                        }
                        .padding(.top, 10) // Adjust for header height
                        .padding(.bottom, 80) // Adjust for floating button
                        
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

                // Fixed Floating Button
                VStack {
                    Spacer()
                    FloatingAddButton()
//                        .padding(.bottom, 0) // Safe area padding
                }
            }
//            .navigationTitle("Dashboard")
        .navigationBarHidden(true) // ✅ Hide default navigation bar
//            .navigationBarHidden(true) // Hide default nav bar
            
        
    }
}



       
// 
//
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//            .environmentObject(AuthManager()) // Inject the AuthManager
//            .previewDevice("iPhone 14 Pro")
//    }
//}
