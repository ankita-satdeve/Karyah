//
//  ProjectD.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import Foundation

struct ProjectD: Identifiable, Codable {
    let id: Int
    let name: String
    let dueDate: String
    let progress: Double
    let startDate: String
    let endDate: String
    let category: String
    let location: String
    let coAdminImage: String?
    let description: String
    let completedTasks: Int
    let totalTasks: Int
}
