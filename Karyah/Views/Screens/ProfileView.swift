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
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Image
                ZStack {
                    if let image = userProfileViewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                    
                    // Camera Button
                    Button(action: {
                        print("Opening Action Sheet...")
                        showActionSheet = true
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
                    
                    CustomTextField(
                        placeholder: "DD/MM/YYYY",
                        text: $userProfileViewModel.dateOfBirth
                    )
                    
                    CustomTextField(placeholder: "Address",
                        text: $userProfileViewModel.address)
                    
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
                    title: "Save Changes →",
                    foregroundColor: .white,
                    isDisabled: false,
                    action: userProfileViewModel.uploadProfilePhoto
                )
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20) // Ensures everything stays within screen bounds
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            userProfileViewModel.fetchUserProfile()
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose an option"), buttons: [
                .default(Text("Open Camera")) { userProfileViewModel.showImagePicker(source: .camera) },
                .default(Text("Upload from Gallery")) { userProfileViewModel.showImagePicker(source: .photoLibrary) },
                .cancel()
            ])
        }
        .sheet(isPresented: $userProfileViewModel.isShowingImagePicker) {
            ImagePicker(sourceType: userProfileViewModel.sourceType, selectedImage: $userProfileViewModel.selectedImage)
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
