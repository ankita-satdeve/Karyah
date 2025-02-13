//
//  HeaderView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var isDrawerOpen = false
    @State private var navigateToNotification = false
    @State private var navigationPath = NavigationPath() // Manage navigation stack

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                VStack {
                    HStack {
                        // Menu Button
                        Button(action: {
                            withAnimation {
                                isDrawerOpen.toggle()
                            }
                        }) {
                            Image("menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33)
                                .foregroundColor(.white)
                                .padding()
                        }

                        Spacer()

                        // App Title
                        Text("KARYAH:")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()

                        // Notification Icon Button
                        Button(action: {
                            navigateToNotification = true
                        }) {
                            Image("notification")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .navigationDestination(isPresented: $navigateToNotification) {
                            //Notifications()
                        }
                    }
                    .padding(.horizontal)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#C6381E"), Color(hex: "#9E240F")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                    )

                    Spacer()
                }

                // Sidebar Drawer
                if isDrawerOpen {
                    SidebarView(isDrawerOpen: $isDrawerOpen, navigationPath: $navigationPath)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }
            }
//            .navigationBarBackButtonHidden(true)
            // Navigation destinations
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .projectList:
                    DashboardView() //ProjectListView()
                case .taskList:
                    DashboardView() //TaskListView()
                case .connectionList:
                    DashboardView() //ManageConnectionsView()
                case .profile:
                    DashboardView()
                case .settings:
                    DashboardView()
                case .help:
                    DashboardView()
                }
            }
        }
    }
}
