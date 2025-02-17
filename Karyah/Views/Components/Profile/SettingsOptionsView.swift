//
//  SettingsOptionsView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

enum ActiveDrawer {
    case changePin, biometric, none
}

enum DrawerStep {
    case initial, enterOTP
}

struct SettingsOptionsView: View {
    @State private var activeDrawer: ActiveDrawer = .none  // Track which drawer is open
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @State private var showSuccessAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        activeDrawer = .changePin  // Open Change PIN Drawer
                    }
                }) {
                    HStack {
                        Text("Change PIN")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }

                Divider()

                Button(action: {
                    withAnimation {
                        activeDrawer = .biometric  // Open Biometric Drawer
                    }
                }) {
                    HStack {
                        Text("Biometric")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                
                ReusableButton(
                                title: "Save Changes  →",
                                foregroundColor: .white,
                                isDisabled: false,
                                action: {
                                    userProfileViewModel.updateProfile {
                                        DispatchQueue.main.async {
                                            showSuccessAlert = true  // ✅ Trigger success alert
                                        }
                                    }
                                }
                            )
//                .padding(.top, 100)

                Spacer()
            }

            // Floating Drawer
            if activeDrawer != .none {
                SettingsDrawer(isVisible: $activeDrawer)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            
            
        }
        .padding(.horizontal, 10)
        .edgesIgnoringSafeArea(.bottom)
    }
}
