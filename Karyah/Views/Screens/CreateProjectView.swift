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
                                
                                // Co-Admin Dropdown
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
//                                        Text("Co-Admin")
//                                            .font(.subheadline)
//                                            .foregroundColor(Color(.systemGray2))
                                        
//                                        Text(viewModel.coAdmin)
//                                            .font(.subheadline)
//                                            .foregroundColor(.primary)
                                        
                                        Text(viewModel.coAdmin.isEmpty ? "Co-Admin" : viewModel.coAdmin)
                                            .font(.subheadline)
                                            .foregroundColor(viewModel.coAdmin.isEmpty ? Color(.systemGray2) : .primary)

                                        
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
//                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                    
//                                    if !viewModel.coAdmin.isEmpty {
//                                        Text("Selected: \(viewModel.coAdmin)")
//                                            .font(.footnote)
//                                            .foregroundColor(.primary)
//                                    }
                                    
                                    if connectionViewModel.isDropdownVisible {
                                        ConnectionDropdownView(
                                            viewModel: connectionViewModel,
                                            selectedName: $viewModel.coAdmin,
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
                        title: "Add Worklist →",
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


//import SwiftUI
//
//struct CreateProjectView: View {
//    @StateObject private var viewModel = CreateProjectViewModel()
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    
//                    // Header
//                    HeaderCard(
//                        title: "Create New Project",
//                        description: "Fill in the details below to create a new project.",
//                        buttonText: nil,
//                        buttonAction: {}
//                    )
//                    
//                    Divider()
//                      
//                    // Form Section
//                    VStack(alignment: .leading, spacing: 20) {
//                        
//                        // Project Name
//                        CustomInputFieldP(icon: "", placeholder: "Project Name", text: $viewModel.projectName)
//                        
//                        // Date Pickers
//                        HStack(spacing: 10) {
//                            // Start Date
//                            DateInputField(title: "Start Date", selection: $viewModel.startDate)
//                            
//                            // End Date
//                            DateInputField(title: "End Date", selection: $viewModel.endDate)
//                        }
//                        
//                        // Additional Fields
//                        VStack(spacing: 16) {
//                            CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Project Category", text: $viewModel.projectCategory)
//                            CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Location", text: $viewModel.location)
//                            CustomInputFieldP(icon: "person", placeholder: "Co-Admin", text: $viewModel.coAdmin)
//                            CustomInputFieldP(icon: "", placeholder: "Description", text: $viewModel.description, isMultiline: true)
//                        }
//                    }
//                    
//                    // Continue Button
//                    ReusableButton(
//                        title: "Add Worklist →",
//                        foregroundColor: .white,
//                        isDisabled: viewModel.isLoading,
//                        isLoading: viewModel.isLoading,
//                        action: viewModel.submitProject
//                    )
//                }
//                .padding() // Ensure padding is applied to the whole VStack
//            }
//            .background(Color(.systemBackground)) // Light/Dark mode support
//            .navigationDestination(isPresented: $viewModel.isNavigatingToDetails) {
//                ProjectListView()
//            }
//        }
//    }
//}
//
//// MARK: - Date Input Field Component
//struct DateInputField: View {
//    var title: String
//    @Binding var selection: Date
//
//    var body: some View {
//        HStack {
//            Image(systemName: "calendar")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 23, height: 26)
//                .padding(.leading)
//
//            VStack(alignment: .leading) {
//                Text(title)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                DatePicker("", selection: $selection, displayedComponents: .date)
//                    .labelsHidden()
//            }
//            .padding()
//        }
//        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//        .frame(height: 50)
//    }
//}
//
//// MARK: - Preview
//#Preview {
//    CreateProjectView()
//}
