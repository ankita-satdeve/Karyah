//
//  ProjectDateDView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct ProjectDateDView: View {
    let label: String
    let date: String
    
    var body: some View {
        VStack {
            Image(systemName: "calendar")
                .foregroundColor(.primary)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(date)
                .font(.subheadline)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
