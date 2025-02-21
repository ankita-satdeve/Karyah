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
    let rowHeight: CGFloat = 60  // Height of the entire row
    let rowWidth: CGFloat = .infinity  // Width of the rectangle

    var body: some View {
        HStack {
            // Names on the Left
            HStack() {
                Text(label)
                    .font(.subheadline)
                    .bold()
                
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
            }

            Spacer()

            // Profile Images on the Right (Overlapping Effect)
            if let coAdmins = coAdmins, !coAdmins.isEmpty {
                HStack(spacing: -10) { // Negative spacing for overlap
                    ForEach(coAdmins, id: \.id) { coAdmin in
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
                        .frame(width: imageSize, height: imageSize) // Fixed size for all profile photos
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                }
            }
        }
        .padding()
        .frame(width: rowWidth, height: rowHeight) // Fixed rectangle size
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 2)
        )
    }
}

