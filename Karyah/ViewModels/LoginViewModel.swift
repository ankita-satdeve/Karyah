//
//  LoginViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

//import SwiftUI
//import Alamofire
//
//class LoginViewModel: ObservableObject {
//    @Published var loginModel = LoginModel()
//    weak var authManager: AuthManager?  // Use weak reference to prevent memory leaks
//    @Published var navigateToRegister = false
//    @Published var navigateToDashboard = false
//    @Published var otp: String = "    "
//    var timerSubscription: Timer?
//    let url: String = "\(BaseURL.url)/auth"
//    
//    func sendOTP() {
//        guard isValidInput(loginModel.phoneEmail) else {
//            loginModel.errorMessage = "Invalid email or phone number."
//            return
//        }
//        
//        let apiUrl = "\(url)/check-email"
//        
//        // Correcting the parameter to match what the API expects
//        let parameters: [String: Any] = [
//            "email": loginModel.phoneEmail
//        ]
//        
//        // Alamofire to call POST api
//        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: OTPResponse.self) { response in
//                switch response.result {
//                case .success(let result):
//                    print("OTP Sent Successfully: \(result.message)")
//                    self.loginModel.isRegistered = result.isRegistered
//                    print("User  Register - \(self.loginModel.isRegistered)")
//                    self.startOTPTimer()
//                case .failure(let error):
//                    // Handling and printing server error message
//                    if let data = response.data,
//                       let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let message = serverMessage["message"] as? String {
//                        print("Server Error: \(message)")
//                        self.loginModel.errorMessage = message
//                    } else {
//                        print("Failed to send OTP: \(error.localizedDescription)")
//                        self.loginModel.errorMessage = error.localizedDescription
//                    }
//                }
//            }
//    }
//    
//    
//    func verifyOTP() {
//        let apiUrl = "\(url)/verify-otp"
//        let parameters: [String: Any] = [
//            "email": loginModel.phoneEmail,
//            "otp": loginModel.otp
//        ]
//        
//        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: LoginResponse.self) { response in
//                switch response.result {
//                case .success(let result):
//                    UserDefaults.standard.set(result.token, forKey: "userToken")
//                    print("Token saved: \(result.token)")
//                    
//                    DispatchQueue.main.async {
//                        self.authManager?.currentScreen = .dashboard  // ✅ Navigate using authManager
//                    }
//                    
//                case .failure(let error):
//                    // Handling and printing server error message
//                    if let data = response.data,
//                       let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let message = serverMessage["message"] as? String {
//                        print("Server Error: \(message)")
//                        self.loginModel.errorMessage = message
//                    } else {
//                        print("Failed to send OTP: \(error.localizedDescription)")
//                        self.loginModel.errorMessage = error.localizedDescription
//                    }
//                }
//            }
//    }
//    
//    func verifyPIN() {
//            let apiUrl = "\(BaseURL.url)/auth/login"
//            let parameters: [String: Any] = [
//                "email": loginModel.phoneEmail,
//                "pin": loginModel.pin
//            ]
//            
//            AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//                .validate()
//                .responseDecodable(of: LoginResponse.self) { response in
//                    switch response.result {
//                    case .success(let result):
//                        UserDefaults.standard.set(result.token, forKey: "userToken")
//                        print("Token saved: \(result.token)")
//                        
//                        DispatchQueue.main.async {
//                            self.authManager?.currentScreen = .dashboard  // ✅ Navigate to Dashboard
//                        }
//                        
//                        
//                    case .failure(let error):
//                        // Handling and printing server error message
//                        if let data = response.data,
//                           let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                           let message = serverMessage["message"] as? String {
//                            print("Server Error: \(message)")
//                            self.loginModel.errorMessage = message
//                        } else {
//                            print("Failed to send PIN: \(error.localizedDescription)")
//                            self.loginModel.errorMessage = error.localizedDescription
//                        }
//                    }
//                }
//        }
//    
//    private func startOTPTimer() {
//        loginModel.isOTPSent = true
//        loginModel.timer = 60
//        loginModel.canResend = false
//        
//        timerSubscription?.invalidate()
//        timerSubscription = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            if self.loginModel.timer > 0 {
//                self.loginModel.timer -= 1
//            } else {
//                timer.invalidate()
//                self.loginModel.canResend = true
//            }
//        }
//    }
//    
//    func isValidInput(_ input: String) -> Bool {
//        let phoneRegex = "^\\d{10}$"
//        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.com$"
//        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: input) ||
//        NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
//    }
//}
