//
//  ProjectCard.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct ProjectCard: View {
    let project: ProjectModel
    @StateObject var viewModel = ProjectListViewModel()
    
    var body: some View {
        HStack(spacing: 12) {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
            }
            .padding()
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(project.projectName)
                    .font(.headline)
                    .foregroundColor(.primary)
                HStack {
                    Image(systemName: "stopwatch")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                    
                    Text(project.endDate ?? "N/A")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
//                    Text("\(project.startDate?.prefix(10))")
//                        .font(.subheadline)
//                        .foregroundColor(.primary)
                }
                
                HStack {
                    Image(systemName: "location")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                    
                    Text(project.location ?? "N/A")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
//                    Text("\(((project.location?.isEmpty) != nil) ? "N/A" : project.location)")
//                        .font(.subheadline)
//                        .foregroundColor(.primary)
                }
                
            }
            .lineLimit(1)
//            .padding()
            
            HStack {
                CircularProgressView(progress: viewModel.project?.progress ?? 0)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12) // Rounded corners for the white box
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray3), lineWidth: 1) // Gray border
        )
        .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 6) // Bottom shadow
    }
}
