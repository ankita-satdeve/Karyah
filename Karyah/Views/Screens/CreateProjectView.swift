//
//  CreateProjectView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct CreateProjectView: View {
    @StateObject private var viewModel = CreateProjectViewModel()
    @StateObject private var connectionViewModel = ConnectionViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header
                    HeaderCard(title: "Create New Project", description: nil, buttonText: nil, buttonAction: false)
                    
                    Divider()
                    
                    // Form Section
                    VStack(alignment: .leading, spacing: 15) {
                        VStack {
                            CustomInputFieldProjectName(icon: "", placeholder: "Project Name", text: $viewModel.projectName)
                            
                            HStack {
                                // Start Date
                                DateInputField(title: "Start Date", date: $viewModel.startDate)
                                DateInputField(title: "End Date", date: $viewModel.endDate)
                            }
                            .padding(.top, 30)
                            
                            //                            HStack {
                            //                                ProjectDateDView(label: "Start Date", date: $viewModel.startDate)
                            //
                            //                                ProjectDateDView(label: "End Date", date: $viewModel.endDate)
                            //                            }
                            
                            VStack {
                                CustomInputFieldP(icon: "chevron.up.chevron.down",
                                                  placeholder: "Project Category",
                                                  text: $viewModel.projectCategory,
                                                  options: ["Category1", "Category2", "Category3"])
                                
                                CustomInputFieldP(icon: "chevron.up.chevron.down",
                                                  placeholder: "Location",
                                                  text: $viewModel.location,
                                                  options: ["Location1", "Location2", "Location3"])
                                
                                // Co-Admin Dropdown
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        if viewModel.selectedCoAdminNames.isEmpty {
                                            Text("Co-Admins")
                                                .font(.headline)
                                                .foregroundColor(Color(.systemGray3))
                                        } else {
                                            // Show names as comma-separated text
                                            Text(viewModel.selectedCoAdminNames.joined(separator: ", "))
                                                .font(.body)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                        }
                                        
                                        Spacer()
                                        
                                        // Display overlapping profile images
                                        ZStack {
                                            ForEach(Array(viewModel.selectedCoAdminPhotos.enumerated()), id: \.0) { index, photo in
                                                AsyncImage(url: URL(string: photo)) { imagePhase in
                                                    if let image = imagePhase.image {
                                                        image.resizable().scaledToFill()
                                                    } else {
                                                        Image(systemName: "person.circle.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                .frame(width: 35, height: 35)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                                .offset(x: CGFloat(index * -15)) // Overlapping effect
                                            }
                                        }
                                        
                                        
                                        Button(action: {
                                            connectionViewModel.isDropdownVisible.toggle()
                                            connectionViewModel.fetchManageConnections()
                                        }) {
                                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.primary)
                                                .accessibilityLabel("Select Co-Admin")
                                        }
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                    
                                    if connectionViewModel.isDropdownVisible {
                                        ConnectionDropdownView(
                                            viewModel: connectionViewModel,
                                            selectedCoAdminIds: $viewModel.coAdmins,
                                            selectedCoAdminNames: $viewModel.selectedCoAdminNames,
                                            selectedCoAdminPhotos: $viewModel.selectedCoAdminPhotos, // Pass profile photos
                                            isDropdownVisible: $connectionViewModel.isDropdownVisible
                                        )
                                    }
                                }
                                
                                LargeCustomInputFieldP(icon: "", placeholder: "Description", text: $viewModel.description)
                            }
                            .padding(.top, 30)
                        }
                    }
                    .padding()
                    
                    // Continue Button
                    ReusableButton(
                        title: "Add Project →",
                        foregroundColor: .white,
                        isDisabled: false,
                        action: viewModel.submitProject
                    )
                    .padding()
                }
                .padding()
            }
            .background(Color(.systemBackground)) // Light/Dark mode support
            .navigationDestination(isPresented: $viewModel.isNavigatingToDetails) {
                ProjectListView()
            }
        }
    }
}

// Date Input Field for Start/End Date
struct DateInputField: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 26)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .frame(height: 50)
    }
}

#Preview {
    CreateProjectView()
}
