//
//  ProfileViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username: String = "User Name"
    @Published var bio: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var dateOfBirth: String = ""
    @Published var gender: Gender = .other
    @Published var address: String = ""
    @Published var categories: [String] = ["Category 1", "Category 2", "Category 3"]
    @Published var selectedCategory: String? = nil
    @Published var locations: [String] = ["Pune", "Mumbai", "Bengaluru"]
    @Published var selectedLocation: String? = nil
    @Published var selectedImage: UIImage? = nil
    @Published var isShowingImagePicker = false
    @State private var showActionSheet = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func changeProfileImage() {}
    func selectCategory(_ category: String) { selectedCategory = category }
    func selectLocation(_ location: String) { selectedLocation = location }
    func saveChanges() {}
    
    func showImagePicker(source: UIImagePickerController.SourceType) {
            self.sourceType = source
            self.isShowingImagePicker = true
        }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Gender"
}


