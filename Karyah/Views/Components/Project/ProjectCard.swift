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
                    Text("Start: \(project.startDate?.prefix(10))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Label("Location: \(((project.location?.isEmpty) != nil) ? "N/A" : project.location)", systemImage: "location.fill")
                    //                    stopwatch
                    //                    location
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
//                    CircularProgressView(progress: 0.80)
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .frame(width: 50, height: 50)
//                        .padding()
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
