//
//  ProjectDetailsView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailsDView: View {
    @ObservedObject var viewModel = ProjectDetailsDViewModel()
    
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
                    
                    if let project = viewModel.project {
                        // Header Card
                        VStack(alignment: .leading) {
                            Text(project.name)
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                            Text("Due Date : \(project.dueDate)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Spacer()
                                CircularProgressView(progress: project.progress)
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
                            Text("Tasks Completed \(project.completedTasks) of \(project.totalTasks)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("In-Progress")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .padding(.horizontal)
                        
                        ProgressView(value: Double(project.completedTasks) / Double(project.totalTasks))
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding(.horizontal)
                        
                        // Date Information
                        HStack {
                            ProjectDateDView(label: "Start Date", date: project.startDate)
                            ProjectDateDView(label: "End Date", date: project.endDate)
                        }
                        .padding(.horizontal)
                        
                        // Project Details
                        ProjectDetailDRow(label: "Project Category", value: project.category)
                        ProjectDetailDRow(label: "Location", value: project.location)
                        ProjectDetailDRow(label: "Description", value: project.description)
                        
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
        .onAppear { viewModel.fetchProjectDetails() }
    }
}


struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailsDView()
            .preferredColorScheme(.light)
    }
}
