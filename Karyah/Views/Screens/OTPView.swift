//
//  OTPView.swift
//  Demo_Login
//
//  Created by Prance Studio on 11/02/25.
//

import SwiftUI

struct OTPView: View {
    @StateObject var viewModel = OTPViewModel()
    @FocusState private var focusedIndex: Int?
    @State private var offset: CGFloat = 0  // To track keyboard offset

    var body: some View {
        NavigationStack {
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

                            TextField("Mobile Number / Email", text: $viewModel.otpModel.phoneEmail)
                                .padding()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.13)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray2), lineWidth: 1)
                                )
                                .keyboardType(.default)
                                .autocapitalization(.none)
                                .focused($focusedIndex, equals: -1) // Assign -1 for the first input field
                                .onChange(of: viewModel.otpModel.phoneEmail) {
                                    viewModel.sendOTP()
                                }

                            Text("Enter OTP:")
                                .font(.subheadline)
                                .foregroundColor(.primary)

                            HStack(spacing: 16) {
                                ForEach(0..<4, id: \.self) { index in
                                    TextField("", text: Binding(
                                        get: {
                                            if index < viewModel.otpModel.otp.count {
                                                let charIndex = viewModel.otpModel.otp.index(viewModel.otpModel.otp.startIndex, offsetBy: index)
                                                return String(viewModel.otpModel.otp[charIndex])
                                            } else {
                                                return ""
                                            }
                                        },
                                        set: { newValue in
                                            if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
                                                if index < viewModel.otpModel.otp.count {
                                                    let startIndex = viewModel.otpModel.otp.index(viewModel.otpModel.otp.startIndex, offsetBy: index)
                                                    viewModel.otpModel.otp.replaceSubrange(startIndex...startIndex, with: newValue)
                                                } else {
                                                    viewModel.otpModel.otp.append(newValue)
                                                }

                                                // Move to next field
                                                if !newValue.isEmpty, index < 3 {
                                                    focusedIndex = index + 1
                                                }
                                            } else if newValue.isEmpty {
                                                // Move to previous field on delete
                                                if index > 0 {
                                                    focusedIndex = index - 1
                                                }
                                            }
                                        }
                                    ))
                                    .frame(width: 45, height: 45) //geometry.size.width * 0.13 
                                    .multilineTextAlignment(.center)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(.systemGray2), lineWidth: 1)
                                    )
                                    .keyboardType(.numberPad)
                                    .focused($focusedIndex, equals: index) // Manage focus state
                                }
                            }

                            if viewModel.otpModel.isOTPSent {
                                HStack {
                                    if viewModel.otpModel.canResend {
                                        Button(action: {
                                            viewModel.sendOTP()
                                        }) {
                                            Text("Resend OTP")
                                                .foregroundColor(.blue)
                                        }
                                    } else {
                                        Text("OTP expiring in:")
                                            .foregroundColor(Color(.systemGray2))
                                        Text("\(viewModel.otpModel.timer)s")
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
                                        viewModel.verifyOTP()
                                    }
                                )
                            }

                            HStack {
                                Text("Already a registered user?")
                                    .foregroundColor(Color(.systemGray2))

                                NavigationLink("Login with PIN", destination: PINView()
                                    .navigationBarBackButtonHidden(true)
                                )
                            }
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .offset(y: offset) // Apply keyboard offset
                        .animation(.easeInOut(duration: 0.3), value: offset)
                    }
                    .padding(.bottom, 40) // Ensures content is fully scrollable
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    addKeyboardObservers()
                }
                .onDisappear {
                    removeKeyboardObservers()
                }
                .onTapGesture {
                    hideKeyboard() // Hide keyboard when tapping anywhere outside
                }
            }
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $viewModel.navigateToRegister) {
                ProfileView()           //RegisterView()
            }
            .fullScreenCover(isPresented: $viewModel.navigateToDashboard) {
                ProfileView()           //DashboardView()
            }
        }
    }

    // MARK: - Keyboard Handling Methods
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                withAnimation {
                    self.offset = -keyboardFrame.height / 2
                }
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            withAnimation {
                self.offset = 0
            }
        }
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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


#Preview {
    OTPView()
}
