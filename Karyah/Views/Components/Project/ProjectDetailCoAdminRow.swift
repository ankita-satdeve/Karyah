//
//  ProjectDetailCoAdminRow.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailCoAdminRow: View {
    let label: String
    let coAdmins: [ProjectDetailModel.CoAdmin]?
    let imageSize: CGFloat = 40 // Fixed size for profile images
    let rowHeight: CGFloat = 60  // Height of the collapsed row
    let baseExpandedHeight: CGFloat = 100 // Base height when expanded
    
    @State private var isExpanded: Bool = false // Track expansion state

    var body: some View {
        HStack() {
            // **Label is always visible**
            Text(label)
                .font(.subheadline)
                .bold()
                .padding(.bottom, 5)

            if !isExpanded { // Show only when NOT expanded
                HStack {
                    if let coAdmins = coAdmins, !coAdmins.isEmpty {
                        Text(coAdmins.map { $0.name }.joined(separator: ", "))
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    } else {
                        Text("N/A")
                            .font(.body)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    // Profile Images on the Right (Overlapping Effect)
                    if let coAdmins = coAdmins, !coAdmins.isEmpty {
                        HStack(spacing: -10) { // Negative spacing for overlap
                            ForEach(coAdmins.prefix(3), id: \.id) { coAdmin in // Show only first 3 in collapsed state
                                profileImage(for: coAdmin)
                            }
                            if coAdmins.count > 3 {
                                Text("+\(coAdmins.count - 3)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
            }

            // Expanded View with full names and images
            if isExpanded, let coAdmins = coAdmins {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(coAdmins, id: \.id) { coAdmin in
                        HStack {
                            profileImage(for: coAdmin)
                            Text(coAdmin.name)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.top, 5)
            }
        }
        .padding()
        .frame(maxWidth: .infinity) // **Expands fully when clicked**
        .frame(minHeight: isExpanded ? expandedHeight() : rowHeight) // **Dynamic height adjustment**
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 2)
        )
        .padding(.vertical, isExpanded ? 20 : 0) // **Padding only when expanded**
        .onTapGesture {
            withAnimation(.easeInOut) {
                isExpanded.toggle()
            }
        }
    }
    
    // Function to calculate expanded height dynamically
    private func expandedHeight() -> CGFloat {
        guard let coAdmins = coAdmins else { return baseExpandedHeight }
        let extraHeight = CGFloat(coAdmins.count) * 50 // Adjust height per co-admin
        return max(baseExpandedHeight, extraHeight)
    }

    // Function to return profile image view
    private func profileImage(for coAdmin: ProjectDetailModel.CoAdmin) -> some View {
        AsyncImage(url: URL(string: coAdmin.profilePhoto ?? "")) { phase in
            if let image = phase.image {
                image.resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: imageSize, height: imageSize)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 2))
    }
}
