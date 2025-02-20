//
//  ProjectModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import Foundation

struct ProjectModel: Identifiable, Codable {
    var id: String   //Int
    var projectName: String
    var location: String?
    var startDate: String?
    var endDate: String?
    var coAdmins: [Int]?
    var projectCategory: String?
    var description: String?
    var taskCount: Int?
    var userId: Int
    var createdAt: String
    var updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case projectName
        case location
        case startDate
        case endDate
        case coAdmins = "coAdminIds"
        case projectCategory
        case description
        case taskCount
        case userId
        case createdAt
        case updatedAt
    }
}

