//
//  CriticalIssueCard.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct CriticalIssueCard: View {
    let issue: IssueModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "exclamationmark.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                
                VStack(alignment: .leading) {
                    Text(issue.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "deskclock")
                            .foregroundColor(.gray)
                            .background(.clear)
                        Text("\(issue.date) \(issue.time)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(issue.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(issue.priority)")
                    .font(.headline).bold()
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4) // Adjust the corner radius as needed
                            .stroke(Color.red, lineWidth: 4) // Red border with 2pt width
                    )
                    .foregroundColor(.primary) // Ensures text remains red

            }
            
            
            
            Divider()
            
            HStack {
                Spacer()
                Button(action: {}) {
                    HStack {
                        Text("Attend")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(UIColor.secondarySystemBackground)))
        .padding(.horizontal)
    }
}


//#Preview {
//    CriticalIssueCard(issue: issue)
//}
