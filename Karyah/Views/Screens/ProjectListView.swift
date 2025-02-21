//
//  ProjectListView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct ProjectListView: View {
    @StateObject private var viewModel = ProjectListViewModel()
    @State private var navigateToCreateProject = false
    
    var filteredProjects: [ProjectModel] {
        if viewModel.searchText.isEmpty {
            return viewModel.projects
        } else {
            return viewModel.projects.filter {
                $0.projectName.localizedCaseInsensitiveContains(viewModel.searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Create Project Button
                
                
                // Header Card
                HeaderCard(
                    title: "All Projects",
                    description: "The list of projects you\n have taken so far",
                    buttonText: "Project",
                    buttonAction: true
                )
                
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    TextField("Search Project", text: $viewModel.searchText)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
                .padding(.horizontal, 20)
                
                // Loading, Error, or Project List
                if viewModel.isLoading {
                    ProgressView("Loading Projects...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                LazyVStack(spacing: 12) {
                                    ForEach(filteredProjects) { project in
                                        NavigationLink(destination: ProjectDetailView(projectId: project.id)) {
                                            ProjectCard(project: project)
                                                .id(project.id)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    .navigationTitle("Projects")
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
                }
            }
//            FloatingAddProjectButton()
            FloatingMenuView()
            
        }
    }
}
#Preview {
    ProjectListView()
}
