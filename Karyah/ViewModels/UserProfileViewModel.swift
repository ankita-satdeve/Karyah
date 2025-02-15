//
//  UserProfileViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI
import PhotosUI
import UIKit
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
    @Published var isShowingImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var profilePhoto: UIImage?
    
    @Published var selectedImage: UIImage? = nil {
        didSet {
            if let _ = selectedImage {
                uploadProfilePhoto()
            }
        }
    }

    
    let url: String = "\(BaseURL.url)/auth"
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func selectLocation(_ location: String) {
        selectedLocation = location
    }
    
    func showImagePicker(source: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(source) {
                self.sourceType = source
                self.isShowingImagePicker = true
            } else {
                print("Source type \(source) is not available!")
            }
        }
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
    
    
    func uploadProfilePhoto() {
        guard let image = profilePhoto else {
            print("No image selected")
            return
        }
        
        let url = "https://api.karyah.in/api/auth/user"
        
        let token = UserDefaults.standard.string(forKey: "userToken")
            
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)", 
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { formData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                formData.append(imageData, withName: "profilePhoto", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .put, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                print("Upload Success: \(data)")
            case .failure(let error):
                print("Upload Failed: \(error.localizedDescription)")
            }
        }
    }
}

