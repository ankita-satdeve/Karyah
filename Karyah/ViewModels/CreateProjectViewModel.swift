//
//  CreateProjectViewModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

class CreateProjectViewModel: ObservableObject {
    @Published var id = ""
    @Published var projectName = ""
    @Published var location = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var coAdmins: [Int] = []
//    @Published var coAdmins: [Int] = [] // Store IDs
    @Published var selectedCoAdminNames: [String] = [] // Store Names
    @Published var projectCategory = ""
    @Published var description = ""
    @Published var isNavigatingToDetails = false
    @Published var isLoading = false
    @Published var taskCount: Int? = nil  // Optional to match API
    @Published var userId: Int = 15  // Hardcoded or retrieved from UserDefaults
    @Published var createdAt = Date()
    @Published var updatedAt = Date()
    
    func submitProject() {
        guard let url = URL(string: "https://api.karyah.in/api/projects/create") else {
            print("Invalid URL")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("Token not found")
            return
        }

        // Convert dates to ISO 8601 format
        let isoFormatter = ISO8601DateFormatter()
        let formattedStartDate = isoFormatter.string(from: startDate)
        let formattedEndDate = isoFormatter.string(from: endDate)
        let formattedCreatedAt = isoFormatter.string(from: createdAt)
        let formattedUpdatedAt = isoFormatter.string(from: updatedAt)

        let projectData = ProjectModel(
            id: id,
            projectName: projectName,
            location: location,  // This should now have the selected value
            startDate: formattedStartDate,
            endDate: formattedEndDate,
            coAdmins: coAdmins.isEmpty ? nil : coAdmins,
            projectCategory: projectCategory,  // This should now have the selected value
            description: description,
            taskCount: taskCount,
            userId: userId,
            createdAt: formattedCreatedAt,
            updatedAt: formattedUpdatedAt
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONEncoder().encode(projectData)
        } catch {
            print("Error encoding project data: \(error.localizedDescription)")
            return
        }

        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("Error submitting project: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }

            if let data = data {
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
            }

            DispatchQueue.main.async {
                self.isNavigatingToDetails = true
            }
        }.resume()
    }
}


