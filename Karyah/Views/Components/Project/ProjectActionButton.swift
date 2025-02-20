//
//  ProjectActionButton.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon)
                Text(title)
                Spacer()
                Image(systemName: "arrow.right")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(color)
            .background(color.opacity(0.05))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(color, lineWidth: 2) // Border with specified color
            )
        }
    }
}

