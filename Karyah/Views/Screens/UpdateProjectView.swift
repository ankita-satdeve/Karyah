//
//  UpdateProjectView.swift
//  Karyah
//
//  Created by Prance Studio on 22/02/25.
//


import SwiftUI

struct UpdateProjectView: View {
//    @StateObject private var connectionViewModel = ConnectionListViewModel()
    @State var project: ProjectDetailModel
    @ObservedObject var projectViewModel: ProjectListViewModel
    @Environment(\.dismiss) var dismiss
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Adjust format based on API
        return formatter
    }()

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header
                    HeaderCard(title: "Update Project", description: nil, buttonText: nil, buttonAction: false)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Form Section
                    VStack(alignment: .leading, spacing: 15) {
                        VStack {
                            CustomInputFieldProjectName(icon: "", placeholder: "Project Name", text: $project.projectName)
                            
                            HStack {
                                DateInputField(
                                    title: "Start Date",
                                    date: Binding(
                                        get: {
                                            let formatter = ISO8601DateFormatter()
                                            formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
                                            return formatter.date(from: project.startDate ?? "") ?? Date()
                                        },
                                        set: { newDate in
                                            let isoFormatter = ISO8601DateFormatter()
                                            project.startDate = isoFormatter.string(from: newDate)
                                        }
                                    )
                                )

                                // End Date
                                DateInputField(
                                    title: "End Date",
                                    date: Binding(
                                        get: {
                                            let formatter = ISO8601DateFormatter()
                                            formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
                                            return formatter.date(from: project.endDate ?? "") ?? Date()
                                        },
                                        set: { newDate in
                                            let isoFormatter = ISO8601DateFormatter()
                                            project.endDate = isoFormatter.string(from: newDate)
                                        }
                                    )
                                )
                            }
                            .padding(.top, 30)


                            VStack {
                                
                                
                                CustomInputFieldP(
                                    icon: "chevron.up.chevron.down",
                                    placeholder: "Project Category",
                                    text: Binding(
                                        get: { project.projectCategory ?? "" }, // Provide default value if nil
                                        set: { project.projectCategory = $0.isEmpty ? nil : $0 } // Convert back to optional when empty
                                    ),
                                    options: ["Residential", "Commercial", "Industrial"]
                                )

                                CustomInputFieldP(
                                    icon: "chevron.up.chevron.down",
                                    placeholder: "Location",
                                    text: Binding(
                                        get: { project.location ?? "" }, // Provide default value if nil
                                        set: { project.location = $0.isEmpty ? nil : $0 } // Convert back to optional when empty
                                    ),
                                    options: ["Mumbai", "Pune", "Nagpur"]
                                )
                               
                                
                                if let coAdmins = project.coAdmins, !coAdmins.isEmpty {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Co-Admins")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        ForEach(coAdmins) { coAdmin in
                                            HStack {
                                                if let profilePhoto = coAdmin.profilePhoto, let url = URL(string: profilePhoto) {
                                                    AsyncImage(url: url) { image in
                                                        image.resizable()
                                                            .scaledToFill()
                                                    } placeholder: {
                                                        Image(systemName: "person.crop.circle.fill")
                                                            .resizable()
                                                            .scaledToFill()
                                                            .foregroundColor(.gray)
                                                    }
                                                    .frame(width: 40, height: 40)
                                                    .clipShape(Circle())
                                                } else {
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(.gray)
                                                        .clipShape(Circle())
                                                }
                                                
                                                Text(coAdmin.name)
                                                    .font(.body)
                                                    .foregroundColor(.primary)
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    }
                                    .padding(.top, 10)
                                }

                                
                                
                                CustomInputFieldProjectName(
                                    icon: "",
                                    placeholder: "Description",
                                    text: Binding(
                                        get: { project.description ?? "" },
                                        set: { project.description = $0 }
                                    )
                                )

                            }
                            .padding(.top, 30)
                        }
                    }
                    .padding()
                    
                    // Continue Button
                    ReusableButton(
                        title: "Update Project →",
                        foregroundColor: .white,
                        isDisabled: false,
                        action: {
                            projectViewModel.updateProject(project) {
                                dismiss()
                            }
                        }
                    )
                    .padding()
                }
                .padding()
            }
            .background(Color(.systemBackground)) // Light/Dark mode support
            .navigationDestination(isPresented: $projectViewModel.isNavigatingToDetails) {
                ProjectListView()
            }
        }
    }
}

