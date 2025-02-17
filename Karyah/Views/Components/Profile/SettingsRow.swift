//
//  SettingsRow.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct SettingsRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: icon)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 10)
//        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
