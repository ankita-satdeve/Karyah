//
//  ProjectCard.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct ProjectCard: View {
    let project: ProjectModel

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(project.projectName)
                    .font(.headline)
                    .foregroundColor(.primary)
                HStack {
                    Label("Location: \(((project.location?.isEmpty) != nil) ? "N/A" : project.location)", systemImage: "location.fill")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Start: \(project.startDate?.prefix(10))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
