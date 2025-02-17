//
//  PINView.swift
//  Demo_Login
//
//  Created by Prance Studio on 12/02/25.
//

import SwiftUI

struct PINView: View {
    @StateObject var pinViewModel = PINViewModel()
    @FocusState private var focusedIndex: Int?
    @State private var offset: CGFloat = 0

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ZStack {
                            Image("brickN")
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

                            TextField("Mobile Number / Email", text: $pinViewModel.pinModel.phoneEmail)
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

                            HStack(spacing: 16) {
                                ForEach(0..<4, id: \.self) { index in
                                    TextField("", text: Binding(
                                        get: {
                                            if index < pinViewModel.pinModel.pin.count {
                                                let charIndex = pinViewModel.pinModel.pin.index(pinViewModel.pinModel.pin.startIndex, offsetBy: index)
                                                return String(pinViewModel.pinModel.pin[charIndex])
                                            } else {
                                                return ""
                                            }
                                        },
                                        set: { newValue in
                                            if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
                                                if index < pinViewModel.pinModel.pin.count {
                                                    let startIndex = pinViewModel.pinModel.pin.index(pinViewModel.pinModel.pin.startIndex, offsetBy: index)
                                                    pinViewModel.pinModel.pin.replaceSubrange(startIndex...startIndex, with: newValue)
                                                } else {
                                                    pinViewModel.pinModel.pin.append(newValue)
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
                                    .frame(width: 50, height: 50)
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
 

                            VStack {
                                ReusableButton(
                                    title: "Continue",
                                    foregroundColor: .white,
                                    isDisabled: false,
                                    action: {
                                        pinViewModel.verifyPIN()
                                    }
                                )
                            }

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
            .fullScreenCover(isPresented: $pinViewModel.navigateToDashboard) {
                DashboardView()
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

#Preview {
    PINView()
}
