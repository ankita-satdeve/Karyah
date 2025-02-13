//
//  FloatingAddButton.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct FloatingAddButton: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                // White Background Strap
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(height: 50)
                    .shadow(radius: 2)
            }
            
            // Floating Button
            VStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 5)
                }
                .offset(y: -25) // Lift button above white background
                .sheet(isPresented: $isSheetPresented) {
                    BottomDrawerView()
                        .presentationDetents([.medium, .large]) // Makes it resizable
                        .presentationDragIndicator(.visible) // Allows swipe down
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Bottom Drawer View
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

// MARK: - Helper Views
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

#Preview {
    FloatingAddButton()
}
