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
                            CustomInputFieldP(icon: "", placeholder: "Project Name", text: $viewModel.projectName)
                            
                            HStack {
                                // Start Date
                                DateInputField(title: "Start Date", date: $viewModel.startDate)
                                DateInputField(title: "End Date", date: $viewModel.endDate)
                            }
                            .padding(.top, 30)
                            
                            VStack {
                                CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Project Category", text: $viewModel.projectCategory)
                                CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Location", text: $viewModel.location)
                                
                                //                                Text(viewModel.coAdmin.isEmpty ? "Co-Admin" : viewModel.coAdmin)
                                //                                    .font(.subheadline)
                                //                                    .foregroundColor(viewModel.coAdmin.isEmpty ? Color(.systemGray2) : .primary)
                                
                                
                                // Co-Admin Dropdown
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(viewModel.selectedCoAdminNames.isEmpty ? "Co-Admins" : viewModel.selectedCoAdminNames.joined(separator: ", "))
                                            .font(.subheadline)
                                            .foregroundColor(viewModel.selectedCoAdminNames.isEmpty ? Color(.systemGray2) : .primary)
                                        
                                        Spacer()
                                        
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
                                            selectedCoAdminIds: $viewModel.coAdmins,  // Pass IDs
                                            selectedCoAdminNames: $viewModel.selectedCoAdminNames, // Pass Names
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
                    
                    //                    Button(action: viewModel.submitProject) {
                    //                        if viewModel.isLoading {
                    //                            ProgressView()
                    //                        } else {
                    //                            Text("Add Worklist →")
                    //                                .font(.headline)
                    //                                .frame(maxWidth: .infinity)
                    //                                .padding()
                    //                                .background(Color.blue)
                    //                                .foregroundColor(.white)
                    //                                .cornerRadius(10)
                    //                        }
                    //                    }
                    //                    .padding()
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
