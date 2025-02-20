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
        
        HStack {
            Image(systemName: "calendar")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 40)
                .foregroundColor(.primary)
            
            VStack {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.primary)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(10)

    }
}
