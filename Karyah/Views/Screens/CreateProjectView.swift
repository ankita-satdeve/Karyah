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
                    VStack {
                        Text("KARYAH:")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)

                        Text("CREATE NEW PROJECT")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#BD361E"), Color(hex: "#2E0808")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding(.top, 50)
//                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

                    // Form Section
                    Group {
                        Text("Add Project Details")
                            .font(.headline)
                            .foregroundColor(.primary)

                        CustomInputFieldP(icon: "plus.circle.fill", placeholder: "Project Name", text: $viewModel.projectName)
                        CustomInputFieldP(icon: "plus.circle.fill", placeholder: "Location", text: $viewModel.location)

                        // Date Pickers
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start Date").font(.subheadline).foregroundColor(.gray)
                                DatePicker("", selection: $viewModel.startDate, displayedComponents: .date)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))

                            VStack(alignment: .leading) {
                                Text("End Date").font(.subheadline).foregroundColor(.gray)
                                DatePicker("", selection: $viewModel.endDate, displayedComponents: .date)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                        }

                        CustomInputFieldP(icon: "plus.circle.fill", placeholder: "Assign Co-Admin", text: $viewModel.coAdmin)
                        CustomInputFieldP(icon: "plus.circle.fill", placeholder: "Project Category", text: $viewModel.projectCategory)
                        CustomInputFieldP(icon: "plus.circle.fill", placeholder: "Description", text: $viewModel.description, isMultiline: true)
                    }

                    // Continue Button
                    Button(action: viewModel.submitProject) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Continue")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding()
                .padding(.bottom, 90)
            }
            .ignoresSafeArea()
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
