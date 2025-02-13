//
//  PINView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct PINView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var keyboardManager = KeyboardManager()
    @StateObject var pinViewModel = LoginViewModel()
    @FocusState private var focusedIndex: Int?
    @State private var offset: CGFloat = 0
    
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
                            .padding(.top, 20)
                        
                        TextField("Mobile Number / Email", text: $pinViewModel.loginModel.phoneEmail)
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
                        //                                .onChange(of: pinViewModel.pinModel.phoneEmail) {
                        //                                    viewModel.sendOTP()
                        //                                }
                        
                        Text("Enter PIN:")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        PinOtpInputView(code: $pinViewModel.loginModel.pin, length: 4)
                        
//                        HStack(spacing: 16) {
//                            ForEach(0..<4, id: \.self) { index in
//                                TextField("", text: Binding(
//                                    get: {
//                                        if index < pinViewModel.loginModel.pin.count {
//                                            let charIndex = pinViewModel.loginModel.pin.index(pinViewModel.pinModel.pin.startIndex, offsetBy: index)
//                                            return String(pinViewModel.loginModel.pin[charIndex])
//                                        } else {
//                                            return ""
//                                        }
//                                    },
//                                    set: { newValue in
//                                        if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
//                                            if index < pinViewModel.loginModel.pin.count {
//                                                let startIndex = pinViewModel.loginModel.pin.index(pinViewModel.loginModel.pin.startIndex, offsetBy: index)
//                                                pinViewModel.loginModel.pin.replaceSubrange(startIndex...startIndex, with: newValue)
//                                            } else {
//                                                pinViewModel.loginModel.pin.append(newValue)
//                                            }
//                                            
//                                            // Move to next field
//                                            if !newValue.isEmpty, index < 3 {
//                                                focusedIndex = index + 1
//                                            }
//                                        } else if newValue.isEmpty {
//                                            // Move to previous field on delete
//                                            if index > 0 {
//                                                focusedIndex = index - 1
//                                            }
//                                        }
//                                    }
//                                ))
//                                .frame(width: 50, height: 50)
//                                .multilineTextAlignment(.center)
//                                .background(Color(.systemBackground))
//                                .cornerRadius(10)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(.systemGray2), lineWidth: 1)
//                                )
//                                .keyboardType(.numberPad)
//                                .focused($focusedIndex, equals: index) // Manage focus state
//                            }
//                        }
                        
                        
                        VStack {
                            ReusableButton(
                                title: "Continue",
                                foregroundColor: .white,
                                isDisabled: false,
                                action: {
                                    pinViewModel.verifyPIN()
                                    authManager.login(token: "user-session-token")
                                }
                            )
                        }
                        
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .offset(y: keyboardManager.offset)
                }
                .padding(.bottom, 40) // Ensures content is fully scrollable
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(y: keyboardManager.offset)
            .onTapGesture {
                            hideKeyboard()
                        }
            }
        
            .ignoresSafeArea()
            
        }
    }

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}


struct PINView_Previews: PreviewProvider {
    static var previews: some View {
        PINView()
            .environmentObject(AuthManager()) // Inject the AuthManager
            .previewDevice("iPhone 14 Pro")
    }
}
