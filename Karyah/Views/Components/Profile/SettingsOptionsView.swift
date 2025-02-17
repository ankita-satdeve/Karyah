//
//  SettingsOptionsView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct SettingsOptionsView: View {
    @State private var showChangePin = false  // Toggle for Change PIN Drawer

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        showChangePin.toggle()  // Open Change PIN Drawer
                    }
                }) {
                    SettingsRow(title: "Change PIN", icon: "chevron.right")
                        .foregroundColor(.primary)
                }

                Divider()

                SettingsRow(title: "Biometric", icon: "chevron.right")

                Spacer()
            }
            .padding()

            // Floating Drawer for Change PIN
            if showChangePin {
                ChangePinDrawer(isVisible: $showChangePin)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
