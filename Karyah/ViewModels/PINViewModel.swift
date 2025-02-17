//
//  PINViewModel.swift
//  Demo_Login
//
//  Created by Prance Studio on 12/02/25.
//

import SwiftUI
import Alamofire

class PINViewModel: ObservableObject {
    @Published var pinModel = PINModel()
    @Published var navigateToDashboard = false
    @Published var otp: String = "    "
 
    func verifyPIN() {
        let apiUrl = "\(BaseURL.url)/auth/login"
        let parameters: [String: Any] = [
            "email": pinModel.phoneEmail,
            "pin": pinModel.pin
        ]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let result):
                    UserDefaults.standard.set(result.token, forKey: "userToken")
                    print("Token saved: \(result.token)")
                    
                    // ✅ Navigate to Dashboard
                    DispatchQueue.main.async {
                        self.navigateToDashboard = true
                    }
                    
                    
                case .failure(let error):
                    // Handling and printing server error message
                    if let data = response.data,
                       let serverMessage = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = serverMessage["message"] as? String {
                        print("Server Error: \(message)")
                        self.pinModel.errorMessage = message
                    } else {
                        print("Failed to send OTP: \(error.localizedDescription)")
                        self.pinModel.errorMessage = error.localizedDescription
                    }
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

