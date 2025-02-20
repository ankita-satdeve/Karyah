//
//  ProjectDetailsDViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

class ProjectDetailsDViewModel: ObservableObject {
    @Published var project: ProjectD?
    
    func fetchProjectDetails() {
        // Simulated API Call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.project = ProjectD(
                id: 1,
                name: "Project Name",
                dueDate: "25 Feb, 2025",
                progress: 0.56,
                startDate: "1 Feb",
                endDate: "25 Feb",
                category: "Software Development",
                location: "New York, USA",
                coAdminImage: "profile_image",
                description: "This is a sample project description.",
                completedTasks: 21,
                totalTasks: 50
            )
        }
    }
}
