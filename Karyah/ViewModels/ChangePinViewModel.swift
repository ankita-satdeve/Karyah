//
//  ChangePinViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 18/02/25.
//

import SwiftUI
import Alamofire

class ChangePinViewModel: ObservableObject {
    @Published var currentPin: String = ""
    @Published var newPin: String = ""
    @Published var message: String = ""
    @Published var isLoading: Bool = false
    
    func changePin() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        let url = "https://api.karyah.in/api/auth/change-pin"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "currentPin": currentPin,
            "newPin": newPin
        ]
        
        isLoading = true
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: ChangePinResponse.self) { response in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch response.result {
                    case .success(let result):
                        self.message = result.message
                    case .failure(let error):
                        self.message = error.localizedDescription
                    }
                }
            }
    }
}
