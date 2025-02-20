//
//  BottomDrawerView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct BottomDrawerView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Add Task Details")
                    .font(.title2).bold()
                    .foregroundColor(.blue)
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            VStack(spacing: 15) {
                TextField("+ Task Name", text: .constant(""))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                
                TextField("+ Select or Add Project", text: .constant(""))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green))
                
                TextField("+ Select or Add Worklist", text: .constant(""))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                
                HStack(spacing: 15) {
                    DateCard(title: "Start Date", date: "1 Feb", icon: "calendar")
                    DateCard(title: "End Date", date: "25 Feb", icon: "calendar")
                    AssignUserCard()
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {}) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            Text("Want to Add Complete Details? Click Here")
                .foregroundColor(.blue)
                .bold()
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
