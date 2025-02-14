//
//  UserProfileViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI
import Alamofire

class UserProfileViewModel: ObservableObject {
    @Published var user: UserProfileModel?
    @Published var dateOfBirth: String = ""
    @Published var gender: Gender = .male
    @Published var address: String = ""
    @Published var categories: [String] = ["Category 1", "Category 2", "Category 3"]
    @Published var locations: [String] = ["Location 1", "Location 2", "Location 3"]
    @Published var selectedLocation: String? = nil

       
    @Published var selectedCategory: String? = nil
    let url: String = "\(BaseURL.url)/auth"
    
    func selectCategory(_ category: String) {
            selectedCategory = category
        }
    
    func selectLocation(_ location: String) {
        selectedLocation = location
    }
    
    func fetchUserProfile() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("No token found")
            return
        }
        
        let apiUrl = "\(url)/user"
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(apiUrl, headers: headers)
            .validate()
            .responseDecodable(of: UserProfileResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    DispatchQueue.main.async {
                        self.user = userResponse.user
                    }
                case .failure(let error):
                    print("Error fetching profile: \(error.localizedDescription)")
                }
            }
    }
}

