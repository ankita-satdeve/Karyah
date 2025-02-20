//
//  ProjectDetailModel.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import Foundation

struct ProjectResponse: Codable {
    let project: ProjectDetailModel
}

struct ProjectDetailModel: Identifiable, Codable {
    var id: String   //Int
    var projectName: String
    var location: String?
    var startDate: String?
    var endDate: String?
    var coAdminIds: [Int]?
    var coAdmins: [CoAdmin]?
    var projectCategory: String?
    var description: String?
    var taskCount: Int?
    var userId: Int
    var createdAt: String
    var updatedAt: String
    
    struct CoAdmin: Codable, Identifiable {
            var id: Int { userId }
            var userId: Int
            var name: String
            var email: String
        }
}

