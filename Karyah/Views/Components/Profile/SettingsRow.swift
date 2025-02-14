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
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: icon)
        }
        .padding()
    }
}
