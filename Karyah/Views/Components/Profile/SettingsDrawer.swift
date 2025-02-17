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
    @State private var phoneEmail = ""
    @State private var otp = ""
    @State private var isOn: Bool = true  //false
    
    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(isVisible == .changePin ? "changePin" : "changePin")
                    Text(drawerStep == .initial ? (isVisible == .changePin ? "Change PIN" : "Set Biometric") : "Change PIN")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
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
                    Text(isVisible == .changePin ? "Are you sure you want to change your PIN?" : "Swipe the toggle to give permission")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()
                    
                    if isVisible == .changePin {
                        CustomTextField(placeholder: "Enter Existing PIN", text: .constant(""))
                        
                        Text("Forgot PIN?")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 10)
                        
                        CustomTextField(placeholder: "Enter New PIN", text: .constant(""))
                            .padding(.bottom, 30)
                        
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
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                            )
                        }
                    }
                    
                    else {
                        
                        VStack {
                            
                            // Show Biometric toggle
                            HStack {
                                
                                Image("fingerPrint")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                        Text("Biometric Access")
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity, alignment: .leading) // Forces text to align left
                                        
                                        Text("Give System Biometric Permission to KARYAH:")
                                            .font(.caption)
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                //                                VStack {
                                //                                    Text("Biometric Access")
                                //                                        .fontWeight(.bold)
                                //                                        .frame(alignment: .leading)
                                //                                    Text("Give System Biometric Permission to KARYAH:")
                                //                                        .font(.caption)
                                //                                        .fixedSize(horizontal: true, vertical: false)
                                //                                }
                                Toggle("", isOn: $isOn)
                            }
                            .padding()
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            
                            Divider()
                                .padding(.bottom, 100)
                            
                            HStack {
                                
                                Button("Continue") {
                                    // Handle OTP verification
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#ECEFFF"))
                                .foregroundColor(.primary)
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                                )
                            }
                        }
                        }
                    
                    
                    
                } else if drawerStep == .enterOTP {
                    Text("Verify via OTP")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom)
                    
                    CustomTextField(placeholder: "Mobile Number", text: $phoneEmail)  //CustomTextField(placeholder: "Mobile Number / Email", text: $pinViewModel.loginModel.phoneEmail)
                    
                    Text("Resend OTP")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 10)
                    
                    // PIN Inputbox
                    PinOtpInputView(code: $otp, length: 4) //PinOtpInputView(code: $pinViewModel.loginModel.pin, length: 4)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 40)
                    //                    HStack {
                    //                        Button("Cancel") {
                    //                            withAnimation {
                    //                                drawerStep = .initial  // Go back to previous step
                    //                            }
                    //                        }
                    //                        .frame(maxWidth: .infinity)
                    //                        .padding()
                    //                        .background(Color(hex: "#FFF2F2"))
                    //                        .foregroundColor(.red)
                    //                        .cornerRadius(14)
                    //                        .overlay(
                    //                            RoundedRectangle(cornerRadius: 14)
                    //                                .stroke(Color(hex: "#FFE5E5"), lineWidth: 2)
                    //                        )
                    //
                    //                        Button("Verify OTP") {
                    //                            // Handle OTP verification
                    //                        }
                    //                        .frame(maxWidth: .infinity)
                    //                        .padding()
                    //                        .background(Color(hex: "#ECEFFF"))
                    //                        .foregroundColor(.primary)
                    //                        .cornerRadius(14)
                    //                        .overlay(
                    //                            RoundedRectangle(cornerRadius: 14)
                    //                                .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                    //                        )
                    //                    }
                    
                    HStack {
                        
                        Button("Continue") {
                            // Handle OTP verification
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#ECEFFF"))
                        .foregroundColor(.primary)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
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
        .padding(.horizontal, -30)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}
