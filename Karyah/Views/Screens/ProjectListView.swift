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
        NavigationView {
            VStack(spacing: 16) {
                
                Button(action: {
                    navigateToCreateProject = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.red)
                        .padding(.leading, 300)
                }
                .navigationDestination(isPresented: $navigateToCreateProject) {
                    CreateProjectView()
                }
                
                // Header Card
                HeaderCard()
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search Project", text: $viewModel.searchText)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
                .padding(.horizontal)

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
                    ScrollView(.vertical, showsIndicators: false) { // Enable scrollbar
                        ScrollViewReader { proxy in
                            LazyVStack(spacing: 12) {
                                ForEach(filteredProjects) { project in
                                    ProjectCard(project: project)
                                        .id(project.id) // Ensure each project has an ID for scrolling
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Projects")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ProjectListView()
}
