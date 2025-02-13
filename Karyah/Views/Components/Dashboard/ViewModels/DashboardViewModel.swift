//
//  DashboardViewModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
//    @Published var projects: [ProjectModel] = []
    @Published var issues: [IssueModel] = []

    init() {
        loadDummyData()
    }

    private func loadDummyData() {
        tasks = [
            TaskModel(title: "Delegated", count: 78),
            TaskModel(title: "Issues", count: 2),
            TaskModel(title: "Connections", count: 4),
            TaskModel(title: "Projects", count: 2)
        ]
        
//        projects = [
//            ProjectModel(projectName: "Kirana", taskCount: 5),
//            ProjectModel(projectName: "Karyah", taskCount: 8)
//        ]
        
        issues = [
            IssueModel(name: "Critical Issue", date: "Nov. 15, 2023", time: "2:00 PM", description: "Description of issue", priority: 3)
        ]
    }
}
