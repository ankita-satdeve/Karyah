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
        var profilePhoto: String?
    }
    /// **Formatted End Date**
    var formattedEndDate: String {
        formatDate(from: endDate)
    }
    
    /// **Formatted Start Date**
    var formattedStartDate: String {
        formatDate(from: startDate)
    }
    
    /// Helper function to convert ISO8601 date to `"21 Feb, 2025"` format
    private func formatDate(from isoDate: String?) -> String {
        guard let isoDate = isoDate else { return "N/A" }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        
        if let date = formatter.date(from: isoDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM, yyyy"
            return outputFormatter.string(from: date)
        }
        return "N/A"
    }
}
