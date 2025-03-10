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
    @State private var showSuccessAlert = false
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Image
                ZStack {
                    if let tempImage = userProfileViewModel.tempProfilePhoto {
                        Image(uiImage: tempImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else if let selectedImage = userProfileViewModel.selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else if let imageUrlString = userProfileViewModel.user?.profilePhoto,
                              let imageUrl = URL(string: imageUrlString) {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }
                    
                    // Camera Button
                    Button(action: {
                        showActionSheet = true
                        userProfileViewModel.isShowingSourceSelection = true
                        isShowingImagePicker = true
                    }) {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(6)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    .offset(x: 35, y: 35)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text(userProfileViewModel.user?.name ?? "User Name")
                    .font(.title)
                    .fontWeight(.bold)
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
                    
                    
                    
//                    CustomTextField(
//                        placeholder: "YYYY-MM-DD",
//                        text: Binding(
//                            get: { userProfileViewModel.user?.dob ?? "" },
//                            set: { userProfileViewModel.user?.dob = $0 }
//                        )
//                    )
                    
                    DatePickerTextField(
                        placeholder: "YYYY-MM-DD",
                        dateString: Binding(
                            get: { userProfileViewModel.user?.dob ?? "" },
                            set: { userProfileViewModel.user?.dob = $0 }
                        )
                    )
                    
                    CustomTextField(
                        placeholder: "Address",
                        text: Binding(
                            get: { userProfileViewModel.user?.location ?? "" },
                            set: { userProfileViewModel.user?.location = $0 }
                        )
                    )
                    
                }
                .padding()
                
                
                //                HStack(spacing: 10) {
                //                    CustomTextField(
                //                        placeholder: "DD/MM/YYYY",
                //                        text: $userProfileViewModel.dateOfBirth
                //                    )
                //                    .frame(maxWidth: 140)
                
                // Uncomment this to enable gender selection
                //                    Picker("Gender", selection: $userProfileViewModel.gender) {
                //                        ForEach(Gender.allCases, id: \.self) { gender in
                //                            Text(gender.rawValue)
                //                                .foregroundColor(.primary)
                //                                .tag(gender)
                //                        }
                //                    }
                //                    .pickerStyle(MenuPickerStyle())
                //                    .frame(maxWidth: 140)
                //                }
                
                
                //                    .multilineTextAlignment(.center)
                //                    .padding(.top, 10)
                //                    .frame(maxWidth: 300)
                
                CategorySelectionView(viewModel: userProfileViewModel)
                
                //                    .frame(maxWidth: 300)
                
                LocationSelectionView(viewModel: userProfileViewModel)
                //                    .frame(maxWidth: 300)
                
                SettingsOptionsView()
                
                ReusableButton(
                                title: "Save Changes  →",
                                foregroundColor: .white,
                                isDisabled: false,
                                action: {
                                    userProfileViewModel.updateProfile {
                                        DispatchQueue.main.async {
                                            showSuccessAlert = true  // ✅ Trigger success alert
                                        }
                                    }
                                }
                            )
                .padding()
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Profile updated successfully!"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                userProfileViewModel.fetchUserProfile()
            }
            
            .actionSheet(isPresented: $userProfileViewModel.isShowingSourceSelection) {
                ActionSheet(title: Text("Choose a source"), buttons: [
                    .default(Text("Open Camera")) {
                        userProfileViewModel.sourceType = .camera
                        userProfileViewModel.isShowingImagePicker = true
                    },
                    .default(Text("Choose from Gallery")) {
                        userProfileViewModel.sourceType = .photoLibrary
                        userProfileViewModel.isShowingImagePicker = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $userProfileViewModel.isShowingImagePicker, onDismiss: {
                userProfileViewModel.uploadProfilePhoto()
            }) {
                ImagePickerWithCrop(sourceType: userProfileViewModel.sourceType, selectedImage: $userProfileViewModel.selectedImage)
            }
            .alert(isPresented: $userProfileViewModel.isUploadSuccess) {
                Alert(
                    title: Text("Success"),
                    message: Text("Profile photo uploaded successfully!"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20) // Ensures everything stays within screen bounds
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
        
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
