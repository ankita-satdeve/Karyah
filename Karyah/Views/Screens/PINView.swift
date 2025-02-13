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
                        
                        // PIN Inputbox
                        PinOtpInputView(code: $pinViewModel.loginModel.pin, length: 4)
                        
                        VStack {
                            ReusableButton(
                                title: "Continue",
                                foregroundColor: .white,
                                isDisabled: false,
                                action: {
                                    pinViewModel.authManager = authManager
                                    pinViewModel.verifyPIN()
                                }
                            )
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
