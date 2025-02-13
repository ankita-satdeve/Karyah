//
//  OTPView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//


import SwiftUI

struct OTPView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var otpViewModel = LoginViewModel()
    @FocusState private var focusedIndex: Int?
    @StateObject private var keyboardManager = KeyboardManager()

    var body: some View {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ZStack {
                            Image("brick")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                                .accessibilityHidden(true)

                            VStack {
                                Text("KARYAH:")
                                    .font(.system(size: geometry.size.width * 0.15))
                                    .fontWeight(.bold)

                                Text("To Be Done")
                                    .font(.system(size: geometry.size.width * 0.05))
                            }
                            .foregroundColor(.white)
                            .shadow(radius: 5) // Adds a shadow for readability
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5)

                        VStack(alignment: .leading, spacing: 20) {
                            Text("Get Started !")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .padding(.top, 15)

                            TextField("Mobile Number / Email", text: $otpViewModel.loginModel.phoneEmail)
                                .padding()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.13)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray2), lineWidth: 1)
                                )
                                .keyboardType(.default)
                                .focused($focusedIndex, equals: -1) // Assign -1 for the first input field
                                .onChange(of: otpViewModel.loginModel.phoneEmail) {
                                    otpViewModel.sendOTP()
                                }

                            Text("Enter OTP:")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            
                            // OTP Inputbox
                            PinOtpInputView(code: $otpViewModel.loginModel.otp, length: 4)

                            if otpViewModel.loginModel.isOTPSent {
                                HStack {
                                    if otpViewModel.loginModel.canResend {
                                        Button(action: {
                                            otpViewModel.sendOTP()
                                        }) {
                                            Text("Resend OTP")
                                                .foregroundColor(.blue)
                                        }
                                    } else {
                                        Text("OTP expiring in:")
                                            .foregroundColor(Color(.systemGray2))
                                        Text("\(otpViewModel.loginModel.timer)s")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal)
                            }

                            VStack {
                                ReusableButton(
                                    title: "Continue",
                                    foregroundColor: .white,
                                    isDisabled: false,
                                    action: {
                                        otpViewModel.authManager = authManager
                                        otpViewModel.verifyOTP()
                                    }
                                )
                            }

                            HStack {
                                Text("Already a registered user?")
                                    .foregroundColor(Color(.systemGray2))
                                
                                Button(action: {
                                    authManager.currentScreen = .pinView
                                }) {
                                    Text("Login with PIN")
                                        .foregroundColor(.blue)
                                }
                            }

                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .offset(y: keyboardManager.offset)
                    }
                    .padding(.bottom, 40) // Ensures content is fully scrollable
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .ignoresSafeArea()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct RegisterView: View {
    var body: some View {
        Text("Register View")
    }
}


struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
            .environmentObject(AuthManager())
            .previewDevice("iPhone 14 Pro")
    }
}

