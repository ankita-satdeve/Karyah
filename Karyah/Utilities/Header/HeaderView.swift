//
//  HeaderView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct HeaderView: View {
    @State private var isDrawerOpen = false
    @Binding var navigationPath: NavigationPath // ✅ Accept navigationPath as Binding

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        withAnimation {
                            isDrawerOpen.toggle()
                        }
                    }) {
                        Image("menu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(10)
                    }

                    Spacer()

                    Text("KARYAH:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        navigationPath.append(NavigationDestination.profile) // ✅ Push to NotificationsView
                    }) {
                        Image("notification")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(10)
                    }
                }
                .padding(.horizontal, 20)
                .frame(height: 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#C6381E"), Color(hex: "#9E240F")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(.white)

                Spacer()
            }

            if isDrawerOpen {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isDrawerOpen.toggle()
                        }
                    }

                SidebarView(isDrawerOpen: $isDrawerOpen, navigationPath: $navigationPath) // ✅ Pass navigationPath
                    .frame(width: 250)
                    .shadow(radius: 5)
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
        }
    }
}
