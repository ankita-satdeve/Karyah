//
//  CreateProjectView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct CreateProjectView: View {
    @StateObject private var viewModel = CreateProjectViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header
                    
                    // Header Card
                    HeaderCard(title: "Create New Project", description: nil, buttonText: nil, buttonAction: false)
                    
                    Divider()
                      
                    // Form Section
                    
                        
                        // Date Pickers
                    VStack(alignment: .leading, spacing: 15) {
                        VStack {
                            
                            CustomInputFieldP(icon: "", placeholder: "Project Name", text: $viewModel.projectName)
                            
                            HStack() {
                                // Start Date
                                HStack {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 23, height: 26, alignment: .leading)
                                        .padding(.leading)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Start Date")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        DatePicker("", selection: $viewModel.startDate, displayedComponents: .date)
                                            .labelsHidden()
                                    }
                                    .padding()
                                }
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                                .frame(height: 50) // Adjusted height for consistency
                                
                                // End Date
                                HStack {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 23, height: 26, alignment: .leading)
                                        .padding(.leading)
                                    
                                    VStack(alignment: .leading) {
                                        Text("End Date")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        DatePicker("", selection: $viewModel.endDate, displayedComponents: .date)
                                            .labelsHidden()
                                    }
                                    .padding()
                                }
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                                .frame(height: 50) // Adjusted height for consistency
                            }
                            .padding(.top, 30)
                        
                            
                            VStack  {
                                CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Project Category", text: $viewModel.projectCategory)
                                CustomInputFieldP(icon: "chevron.up.chevron.down", placeholder: "Location", text: $viewModel.location)
                                
                                
                                
                                CustomInputFieldP(icon: "person", placeholder: "Co-Admin", text: $viewModel.coAdmin)
                                CustomInputFieldP(icon: "", placeholder: "Description", text: $viewModel.description, isMultiline: true)
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
//                        isLoading: viewModel.isLoading,
                        action: viewModel.submitProject
                    )
                    .padding()

                    
                    
                    Button(action: viewModel.submitProject) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Add Worklist →")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .padding()
            }
//            .ignoresSafeArea()
            .background(Color(.systemBackground)) // Light/Dark mode support
            .navigationDestination(isPresented: $viewModel.isNavigatingToDetails) {
               ProjectListView()
            }
        }
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
