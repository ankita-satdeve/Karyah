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
    @Published var gender: Gender = .male // change as default
    @Published var address: String = ""
    @Published var categories: [String] = []
    @Published var locations: [String] = []
    @Published var selectedLocation: String? = nil
    @Published var selectedCategory: String? = nil
    @Published var isShowingImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var profilePhoto: UIImage?
    @Published var selectedImage: UIImage?
    @Published var profileImage: UIImage?
    @Published var isShowingSourceSelection = false
    @Published var tempProfilePhoto: UIImage?
    @Published var isUploadSuccess: Bool = false
    
    let url: String = "\(BaseURL.url)/auth/user"
    
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
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request("\(url)", headers: headers)
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
        guard let image = selectedImage, let token = UserDefaults.standard.string(forKey: "userToken") else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let apiUrl = "\(url)"
        
        AF.upload(multipartFormData: { formData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                formData.append(imageData, withName: "profilePhoto", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: apiUrl, method: .put, headers: headers)
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: UserProfileResponse.self) { response in
            switch response.result {
            case .success(let userResponse):
                DispatchQueue.main.async {
                    self.user = userResponse.user
                    self.selectedImage = nil
                    self.tempProfilePhoto = nil
                    self.isUploadSuccess = true
                }
                print("Upload Success: \(userResponse)")
            case .failure(let error):
                print("Upload Failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    func updateProfile(completion: @escaping () -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("Token not found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let apiUrl = "\(url)"
        
        let multipartFormData = MultipartFormData()
        
        let profileFields: [String: String?] = [
            "bio": self.user?.bio,
            "email": self.user?.email,
            "name": self.user?.name,
            "phone": self.user?.phone,
            "location": self.user?.location,
            "dob": self.user?.dob
        ]
        
        for (key, value) in profileFields {
            if let data = value?.data(using: .utf8) {
                multipartFormData.append(data, withName: key)
            }
        }
        
        
        
        AF.upload(multipartFormData: multipartFormData, to: apiUrl, method: .put, headers: headers)
            .validate()
            .responseDecodable(of: UserProfileResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    DispatchQueue.main.async {
                        self.user = userResponse.user
                        completion()  //  Call the completion handler
                    }
                    print("Upload Success: \(userResponse)")
                case .failure(let error):
                    print("Upload Failed: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Server Response: \(String(data: data, encoding: .utf8) ?? "Invalid Response")")
                    }
                }
            }
    }
}



//import SwiftUI
//import PhotosUI
//import UIKit
//import Alamofire
//
//class UserProfileViewModel: ObservableObject {
//    @Published var user: UserProfileModel?
//    @Published var dateOfBirth: String = ""
//    @Published var gender: Gender = .male
//    @Published var address: String = ""
//    @Published var categories: [String] = ["Category 1", "Category 2", "Category 3"]
//    @Published var locations: [String] = ["Location 1", "Location 2", "Location 3"]
//    @Published var selectedLocation: String? = nil
//    @Published var selectedCategory: String? = nil
//    @Published var isShowingImagePicker = false
//    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @Published var profilePhoto: UIImage?
//    @Published var selectedImage: UIImage?
//    @Published var profileImage: UIImage?
//    @Published var isShowingSourceSelection = false
//    @Published var tempProfilePhoto: UIImage?
//    @Published var isUploadSuccess: Bool = false
//    
//    let url: String = "\(BaseURL.url)/auth"
//    
//    func selectCategory(_ category: String) {
//        selectedCategory = category
//    }
//    
//    func selectLocation(_ location: String) {
//        selectedLocation = location
//    }
//    
//    func showImagePicker(source: UIImagePickerController.SourceType) {
//        DispatchQueue.main.async {
//            if UIImagePickerController.isSourceTypeAvailable(source) {
//                self.sourceType = source
//                self.isShowingImagePicker = true
//            } else {
//                print("Source type \(source) is not available!")
//            }
//        }
//    }
//    
//    
//    func fetchUserProfile() {
//        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
//            print("No token found")
//            return
//        }
//        
//        let apiUrl = "\(url)/user"
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)",
//            "Content-Type": "application/json"
//        ]
//        
//        AF.request(apiUrl, headers: headers)
//            .validate()
//            .responseDecodable(of: UserProfileResponse.self) { response in
//                switch response.result {
//                case .success(let userResponse):
//                    DispatchQueue.main.async {
//                        self.user = userResponse.user
//                    }
//                case .failure(let error):
//                    print("Error fetching profile: \(error.localizedDescription)")
//                }
//            }
//    }
//
//    func uploadProfilePhoto() {
//        guard let image = selectedImage, let token = UserDefaults.standard.string(forKey: "userToken") else { return }
//        
//        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
//        let apiUrl = "\(url)/user"
//        
//        AF.upload(multipartFormData: { formData in
//            if let imageData = image.jpegData(compressionQuality: 0.8) {
//                formData.append(imageData, withName: "profilePhoto", fileName: "image.jpg", mimeType: "image/jpeg")
//            }
//        }, to: apiUrl, method: .put, headers: headers)
//        .uploadProgress { progress in
//            print("Upload Progress: \(progress.fractionCompleted)")
//        }
//        .responseDecodable(of: UserProfileResponse.self) { response in
//            switch response.result {
//            case .success(let userResponse):
//                DispatchQueue.main.async {
//                    self.user = userResponse.user
//                    self.selectedImage = nil
//                    self.tempProfilePhoto = nil
//                    self.isUploadSuccess = true
//                }
//                print("Upload Success: \(userResponse)")
//            case .failure(let error):
//                print("Upload Failed: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    
//    func updateProfile(completion: @escaping () -> Void) {
//        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
//            print("Token not found")
//            return
//        }
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)"
//        ]
//        
//        let apiUrl = "\(url)/user"
//        
//        let multipartFormData = MultipartFormData()
//        
//        // Append profile photo if available
//        //        if let image = self.profileImage, let imageData = image.jpegData(compressionQuality: 0.8) {
//        //            multipartFormData.append(imageData, withName: "profilePhoto", fileName: "image.jpg", mimeType: "image/jpeg")
//        //        }
//        
//        //        uploadProfilePhoto()
//
//        
//        let profileFields: [String: String?] = [
//            "bio": self.user?.bio,
//            "email": self.user?.email,
//            "name": self.user?.name,
//            "phone": self.user?.phone,
//            "location": self.user?.location,
//            "dob": self.user?.dob
//        ]
//
//        for (key, value) in profileFields {
//            if let data = value?.data(using: .utf8) {
//                multipartFormData.append(data, withName: key)
//            }
//        }
//
//
//        
//        AF.upload(multipartFormData: multipartFormData, to: apiUrl, method: .put, headers: headers)
//            .validate()
//            .responseDecodable(of: UserProfileResponse.self) { response in
//                switch response.result {
//                case .success(let userResponse):
//                    DispatchQueue.main.async {
//                        self.user = userResponse.user
//                        completion()  // ✅ Call the completion handler
//                    }
//                    print("Upload Success: \(userResponse)")
//                case .failure(let error):
//                    print("Upload Failed: \(error.localizedDescription)")
//                    if let data = response.data {
//                        print("Server Response: \(String(data: data, encoding: .utf8) ?? "Invalid Response")")
//                    }
//                }
//            }
//    }
//    
//    
//}
//
