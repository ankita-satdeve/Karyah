//
//  ProfileView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    
                    //                    ProfileImageView(url: userProfileViewModel.user?.profilePhoto, geometry: geometry)
                    ZStack {
//                        VStack {
                            if let image = userProfileViewModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                //                            }
                                
                                //                            VStack {
                                Button(action: {
                                    showActionSheet = true
                                }) {
                                    Image(systemName: "camera.fill")
                                        .font(.largeTitle)
                                        .padding()
                                }
                                .padding(.leading, 120)
                                .padding(.top, 100)
                                .actionSheet(isPresented: $showActionSheet) {
                                    ActionSheet(title: Text("Choose an option"), buttons: [
                                        .default(Text("Open Camera")) { userProfileViewModel.showImagePicker(source: .camera) },
                                        .default(Text("Upload from Gallery")) { userProfileViewModel.showImagePicker(source: .photoLibrary) },
                                        .cancel()
                                    ])
                                    //                                }
                                }
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(sourceType: sourceType, selectedImage: $userProfileViewModel.profilePhoto)
                                }
                            }
                        }
                        
                        
                        
                        
                        Text(userProfileViewModel.user?.name ?? "User Name")
                            .font(.title)
                            .foregroundColor(.primary)
                            .accessibilityLabel("User Name")
                        
                        VStack(spacing: 10) {
                            LargeCustomTextField(
                                placeholder: "Bio",
                                text: Binding(
                                    get: { userProfileViewModel.user?.bio ?? "" },
                                    set: { userProfileViewModel.user?.bio = $0 }
                                )
                            )
                            
                            CustomTextField(
                                placeholder: "Phone Number",
                                text: Binding(
                                    get: { userProfileViewModel.user?.phone ?? "" },
                                    set: { userProfileViewModel.user?.phone = $0 }
                                )
                            )
                            
                            CustomTextField(
                                placeholder: "Email",
                                text: Binding(
                                    get: { userProfileViewModel.user?.email ?? "" },
                                set: { userProfileViewModel.user?.email = $0 }
                            )
                        )
                        
                        HStack(spacing: 10) {
                            CustomTextField(
                                placeholder: "DD/MM/YYYY",
                                text: $userProfileViewModel.dateOfBirth
                            )
                            

//                            Picker("Gender", selection: $userProfileViewModel.gender) {
//                                ForEach(Gender.allCases, id: \.self) { gender in
//                                    Text(gender.rawValue)
//                                        .foregroundColor(.primary)
//                                        .tag(gender)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//                            .frame(width: geometry.size.width * 0.45, height: 50)
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray2), lineWidth: 1)
                            )
                        }
                        
                        CustomTextField(placeholder: "Address", text: $userProfileViewModel.address)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal)
                    
                    CategorySelectionView(viewModel: userProfileViewModel)
                        
                    LocationSelectionView(viewModel: userProfileViewModel)
                        .padding(.horizontal, 20)
                    SettingsOptionsView()
                    
                    ReusableButton(
                        title: "Save Changes →",
                        foregroundColor: .white,
                        isDisabled: false,
//                        action: userProfileViewModel.fetchUserProfile
                        action: userProfileViewModel.uploadProfilePhoto
                    )
                    .padding()
                }
                .padding()
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: sourceType, selectedImage: $userProfileViewModel.profilePhoto)
                }

            }
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            userProfileViewModel.fetchUserProfile()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
        .preferredColorScheme(.light)
        NavigationView {
            ProfileView()
        }
        .preferredColorScheme(.dark)
    }
}
