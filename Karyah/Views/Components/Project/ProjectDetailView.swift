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
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(project.projectName)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Text("Due Date: \(project.endDate ?? "N/A")")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxHeight: .infinity, alignment: .topLeading) 
                            .padding()

                            Spacer()
                            CircularProgressView(progress: 0.75)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 70, height: 70)
                                .padding()
                        }
                        .frame(height: 150)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [
                                Color(hex: "#C6381E"),
                                Color(hex: "#9E240F")
                            ]),
                            startPoint: .trailing,
                            endPoint: .leading)
                        )
                        
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Task Progress
                        HStack {
                            Text("Tasks Completed 5 of 10") // Placeholder, replace with actual value later
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Spacer()
                            HStack {
                                Image(systemName: "rectangle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.orange)
                                    .frame(width: 12, height: 12)
                                Text("In-Progress")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                            }
                            
                        }
                        .padding(.horizontal)
                        

                        ProgressView(value: 0.5)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(.green) // Apply green color
                            .scaleEffect(y: 3, anchor: .center) // Increase thickness
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
                        
                        ProjectDetailDescriptionRow(label: "Description", value: project.description ?? "N/A")
                        
                        // Buttons
                        VStack(spacing: 10) {
                            ProjectActionButton(title: "Raise an Issue", icon: "issue", color:  Color(hex: "#C6381E")) {}
                            ProjectActionButton(title: "View Issue List", icon: "issue", color: Color(hex: "#C6381E")) {}
                            
                        }
                        .padding(.horizontal)
                        
                        
                        VStack {
                            ReusableButton(
                                title: "View All Worklists  →",   //assign from own- save changes, if other then show View All Projects
                                foregroundColor: .white,
                                isDisabled: false,
                                action: {
                                    viewModel.fetchProjects()   //remove later with project
                                }
                            )
                        }
                        .padding()
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
