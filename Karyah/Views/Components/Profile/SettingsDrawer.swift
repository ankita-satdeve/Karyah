//
//  SettingsDrawer.swift
//  Karyah
//
//  Created by Prance Studio on 17/02/25.
//

import SwiftUI

struct SettingsDrawer: View {
    @Binding var isVisible: ActiveDrawer
    @State private var drawerStep: DrawerStep = .initial
    @State private var otp = ""

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: isVisible == .changePin ? "lock.fill" : "faceid")
                    Text(drawerStep == .initial ? (isVisible == .changePin ? "Change PIN" : "Set Biometric") : "Enter OTP")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            isVisible = .none  // Close drawer
                            drawerStep = .initial  // Reset step
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                    }
                }

                Divider()

                if drawerStep == .initial {
                    Text(isVisible == .changePin ? "Are you sure you want to change your PIN?" : "Enable Biometric Authentication?")
                        .font(.headline)
                        .foregroundColor(.primary)

                    if isVisible == .changePin {
                        CustomTextField(placeholder: "Enter Existing PIN", text: .constant(""))
                        CustomTextField(placeholder: "Enter New PIN", text: .constant(""))

                        Text("Forgot PIN?")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    HStack {
                        Button("No, Cancel") {
                            withAnimation {
                                isVisible = .none  // Close drawer
                                drawerStep = .initial  // Reset step
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#FFF2F2"))
                        .foregroundColor(.red)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(hex: "#FFE5E5"), lineWidth: 2)
                        )

                        Button("Yes, Change") {
                            withAnimation {
                                drawerStep = .enterOTP  // Switch to OTP step
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#ECEFFF"))
                        .foregroundColor(.primary)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                        )
                    }
                } else if drawerStep == .enterOTP {
                    Text("Enter the OTP sent to your phone/email.")
                        .font(.headline)
                        .foregroundColor(.primary)

                    CustomTextField(placeholder: "Enter OTP", text: $otp)

                    HStack {
                        Button("Cancel") {
                            withAnimation {
                                drawerStep = .initial  // Go back to previous step
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#FFF2F2"))
                        .foregroundColor(.red)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(hex: "#FFE5E5"), lineWidth: 2)
                        )

                        Button("Verify OTP") {
                            // Handle OTP verification
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#ECEFFF"))
                        .foregroundColor(.primary)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                        )
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -5)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
}
