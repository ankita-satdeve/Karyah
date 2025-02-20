//
//  ProjectDetailDescriptionRow.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailDescriptionRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label) :")
                .font(.subheadline)
                .bold()
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.top, -50)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading) // Increased height
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray3), lineWidth: 2)
        )
        .padding(.horizontal)
    }
}


