//
//  OTPViewModel.swift
//  Demo_Login
//
//  Created by Prance Studio on 11/02/25.
//

import SwiftUI
import Alamofire

class OTPViewModel: ObservableObject {
    @Published var otpModel = OTPModel()
    @Published var navigateToRegister = false
    @Published var navigateToDashboard = false
    @Published var otp: String = "    "
    var timerSubscription: Timer?
    
    func sendOTP() {
        guard isValidInput(otpModel.phoneEmail) else {
            otpModel.errorMessage = "Invalid email or phone number."
            return
        }
        
        let apiUrl = "\(BaseURL.url)/auth/check-email"
        
        // Correcting the parameter to match what the API expects
        let parameters: [String: Any] = [
            "email": otpModel.phoneEmail
        ]
        
        // Alamofire to call POST api
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: OTPResponse.self) { response in
                switch response.result {
                case .success(let result):
                    print("OTP Sent Successfully: \(result.message)")
                    self.otpModel.isRegistered = result.isRegistered
                    print("User  Register - \(self.otpModel.isRegistered)")
                    self.startOTPTimer()
                case .failure(let error):
                    // Handling and printing server error message
                    if let data = response.data,
                       let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = serverMessage["message"] as? String {
                        print("Server Error: \(message)")
                        self.otpModel.errorMessage = message
                    } else {
                        print("Failed to send OTP: \(error.localizedDescription)")
                        self.otpModel.errorMessage = error.localizedDescription
                    }
                }
            }
    }
    
    
    func verifyOTP() {
        let apiUrl = "\(BaseURL.url)/auth/verify-otp"
        let parameters: [String: Any] = [
            "email": otpModel.phoneEmail,
            "otp": otpModel.otp
        ]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: VerifyOTPResponse.self) { response in
                switch response.result {
                case .success(let result):
                    UserDefaults.standard.set(result.token, forKey: "userToken")
                    print("Token saved: \(result.token)")
                    if self.otpModel.isRegistered {
                        self.navigateToDashboard = true
                    } else {
                        self.navigateToRegister = true
                    }
                    
                case .failure(let error):
                    // Handling and printing server error message
                    if let data = response.data,
                       let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = serverMessage["message"] as? String {
                        print("Server Error: \(message)")
                        self.otpModel.errorMessage = message
                    } else {
                        print("Failed to send OTP: \(error.localizedDescription)")
                        self.otpModel.errorMessage = error.localizedDescription
                    }
                }
            }
    }
    
    
    private func startOTPTimer() {
        otpModel.isOTPSent = true
        otpModel.timer = 60
        otpModel.canResend = false
        
        timerSubscription?.invalidate()
        timerSubscription = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.otpModel.timer > 0 {
                self.otpModel.timer -= 1
            } else {
                timer.invalidate()
                self.otpModel.canResend = true
            }
        }
    }
    
    func isValidInput(_ input: String) -> Bool {
        let phoneRegex = "^\\d{10}$"
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.com$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: input) ||
        NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
    }
}
