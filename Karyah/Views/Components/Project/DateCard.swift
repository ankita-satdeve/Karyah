//
//  DateCard.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct DateCard: View {
    var title: String
    var date: String
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.caption)
            
            Text(date)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
    }
}

struct AssignUserCard: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .font(.title)
                .foregroundColor(.gray)
            Text("+ Assign To")
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
    }
}
