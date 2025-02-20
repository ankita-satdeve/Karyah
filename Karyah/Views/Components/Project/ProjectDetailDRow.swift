//
//  ProjectDetailDRow.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDetailDRow: View {
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
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray2), lineWidth: 2) // Border with same color
        )
        .padding(.horizontal)
    }
}

