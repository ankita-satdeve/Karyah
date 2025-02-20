//
//  ProjectDetailView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailView: View {
    @StateObject var viewModel = ProjectListViewModel()
    var projectId: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Back Button
                    Button(action: { /* Handle Back Action */ }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back").font(.title3)
                        }
                    }
                    .padding(.horizontal)

                    if viewModel.isLoading {
                        ProgressView("Loading Project...")
                            .frame(maxWidth: .infinity, minHeight: 200)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else if let project = viewModel.project {
                        // Header Card
                        VStack(alignment: .leading) {
                            Text(project.projectName)
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                            Text("Due Date: \(project.endDate ?? "N/A")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Spacer()
                                CircularProgressView(progress: 0.75) // Placeholder Progress
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal)

                        // Task Progress
                        HStack {
                            Text("Tasks Completed 5 of 10") // Placeholder
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("In-Progress")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .padding(.horizontal)

                        ProgressView(value: 0.5) // Placeholder
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding(.horizontal)

                        // Date Information
                        HStack {
                            ProjectDateDView(label: "Start Date", date: project.startDate ?? "N/A")
                            ProjectDateDView(label: "End Date", date: project.endDate ?? "N/A")
                        }
                        .padding(.horizontal)

                        // Project Details
                        ProjectDetailDRow(label: "Project Category", value: project.projectCategory ?? "N/A")
                        ProjectDetailDRow(label: "Location", value: project.location ?? "N/A")
                        ProjectDetailDRow(label: "Description", value: project.description ?? "N/A")

                        // Co-Admins List
                        if let coAdmins = project.coAdmins, !coAdmins.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Co-Admins:")
                                    .font(.headline)
                                    .padding(.top, 8)
                                ForEach(coAdmins) { coAdmin in
                                    Text("- \(coAdmin.name) (📧 \(coAdmin.email))")
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Buttons
                        VStack(spacing: 10) {
                            ProjectActionButton(title: "Raise an Issue", icon: "exclamationmark.triangle.fill", color: .red) {}
                            ProjectActionButton(title: "View Issue List", icon: "list.bullet", color: .red) {}
                            ProjectActionButton(title: "View All Worklists", icon: "arrow.right", color: .blue) {}
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            viewModel.fetchProject(by: projectId)
        }
    }
}



//import SwiftUI
//
//struct ProjectDetailView: View {
//    @StateObject var viewModel = ProjectListViewModel()
//    var projectId: String
//    
//    var body: some View {
//        VStack {
//            if viewModel.isLoading {
//                ProgressView("Loading Project...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage).foregroundColor(.red)
//            } else if let project = viewModel.project {
//                VStack(alignment: .leading, spacing: 16) {
//                    Text(project.projectName)
//                        .font(.title)
//                        .bold()
//                    
//                    Text("Description: \(project.description ?? "N/A")")
//                    Text("Category: \(project.projectCategory ?? "N/A")")
//                    Text("Location: \(project.location ?? "N/A")")
//                    Text("Start Date: \(project.startDate ?? "N/A")")
//                    Text("End Date: \(project.endDate ?? "N/A")")
//                    
//                    if let coAdmins = project.coAdmins, !coAdmins.isEmpty {
//                        Text("Co-Admins:")
//                        ForEach(coAdmins) { coAdmin in
//                            Text("- \(coAdmin.name) (📧 \(coAdmin.email))")
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//        .onAppear {
//            viewModel.fetchProject(by: projectId)
//        }
//        .navigationTitle("Project Details")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
