//
//  ProjectDetailView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailView: View {
    @StateObject var viewModel = ProjectListViewModel()
    @State private var isEditing = false
    var projectId: String
    let currentUserId = UserDefaults.standard.value(forKey: "userId") as! Int
    
    
    var body: some View {
        NavigationStack{
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

                            // Edit Button - Show only if the user is the owner
                            HStack {
                                Spacer()
                                    Menu {
                                        Button(action: {
                                            print("Edit project")
                                            isEditing = true
                                            
                                        }) {
                                            Text("Edit project")
                                                .foregroundColor(.primary)
                                        }
                                    } label: {
                                        Image("menu") 
                                            .foregroundColor(.primary)
                                            .padding()
                                    }
                                    .menuStyle(BorderlessButtonMenuStyle()) // Removes default button styling
                                    .background(Color.clear)
                                    .frame(alignment: .topLeading)
                                    .padding(.top, -45)
        
                            }
                            
                            
                            // Header Card
                            HStack {
                                
                                VStack(alignment: .leading) {
                                    Text(project.projectName)
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("Due Date: \(project.formattedEndDate)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(maxHeight: .infinity, alignment: .topLeading)
                                .padding()
                                
                                Spacer()
                                
                                
                                
                                
                                CircularProgressHeaderView(progress: project.progress ?? 0)
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
                                    
                                    Text(displayStatus(for: project.status))
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
                                ProjectDateDView(label: "Start Date", date: project.formattedStartDate)
                                    
                                ProjectDateDView(label: "End Date", date: project.formattedEndDate)     
                            }
                         
                            
                            // Project Details
                            ProjectDetailDRow(label: "Project Category", value: project.projectCategory ?? "N/A")
                            ProjectDetailDRow(label: "Location", value: project.location ?? "N/A")
                            
                            
                            ProjectDetailCoAdminRow(
                                label: "Co-Admins: ",
                                coAdmins: project.coAdmins
                            )
                            .padding(.horizontal)
                        
                            
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
                                        viewModel.isNavigatingToDetails = true   //remove later with project
                                    }
                                )
                            }
                            .padding()
                        }
                            
                        
                    }
                    .padding(.vertical)
                    .navigationDestination(isPresented: $viewModel.isNavigatingToDetails) {
                        ProjectListView()
                    }
//                    .navigationDestination(isPresented: $isEditing) {
//                        UpdateProjectView(project: project)
//                    }
                }
                
            }
        }
        .onAppear {
            viewModel.fetchProject(by: projectId)
        }
        .navigationDestination(isPresented: $isEditing) {
            if let project = viewModel.project {
                UpdateProjectView(project: project, projectViewModel: viewModel)
            }
        }

    }
    
    func displayStatus(for status: String?) -> String {
        switch status?.lowercased() {
        case "pending": return "Pending"
        case "in progress": return "In Progress"
        case "completed": return "Completed"
        default: return "No Status"
        }
    }
}


