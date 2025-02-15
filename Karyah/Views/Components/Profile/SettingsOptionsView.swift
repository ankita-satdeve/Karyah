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
        VStack {
            Button(action: {
                withAnimation {
                    showChangePin.toggle()  // Open Change PIN Drawer
                }
            }) {
                SettingsRow(title: "Change PIN", icon: "chevron.right")
            }

            Divider()

            SettingsRow(title: "Biometric", icon: "chevron.right")

//            if !showChangePin { // Hide "Save Changes" when PIN drawer is open
//                ReusableButton(
//                    title: "Save Changes →",
//                    foregroundColor: .white,
//                    isDisabled: false,
//                    action: {
//                        print("Save Changes Clicked")
//                    }
//                )
//                .padding(.top, 20)
//            }
        }
        .padding(.horizontal)
        .overlay(
            Group {
                if showChangePin {
                    ChangePinView(isVisible: $showChangePin)
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }
            }
        )
    }
}
