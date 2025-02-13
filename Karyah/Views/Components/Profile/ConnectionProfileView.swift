//
//  ConnectionProfileView.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

import SwiftUI

struct ConnectionProfileView: View {
    @Environment(\.colorScheme) var colorScheme // Detect Dark/Light mode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Back Button and Profile Title
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Text("Profile")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: {
                        // Options action
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                
                // Profile Image
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("Connection Name")
                    .font(.headline)
                    .padding(.top, 4)
                
                // Bio Input
                TextField("Bio", text: .constant(""))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                
                // Date & Gender Fields
                HStack {
                    TextField("DD/MM/YYYY", text: .constant(""))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                    
                    TextField("Gender", text: .constant(""))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                }
                .padding(.horizontal)
                
                // Location Label
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    Text("Location")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Business Categories
                VStack(alignment: .leading, spacing: 8) {
                    Text("Business Category")
                        .font(.subheadline)
                        .bold()
                    
                    HStack {
                        CategoryButton(title: "Category 1", color: Color(UIColor.systemBackground))
                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#C6381E"), Color(hex: "#9E240F")]), startPoint: .bottomTrailing, endPoint: .topLeading))
                            .cornerRadius(10)
                        CategoryButton(title: "Category 2", color: .gray)
                        CategoryButton(title: "Category 3", color: .gray)
                    }
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 16)
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea()) // Adapts to dark/light mode
    }
}

// Category Button Component
struct CategoryButton: View {
    var title: String
    var color: Color
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// Preview
struct ConnectionProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConnectionProfileView()
                .previewDevice("iPhone 14 Pro")
            
            ConnectionProfileView()
                .previewDevice("iPhone SE (3rd generation)")
                .environment(\.colorScheme, .dark)
        }
    }
}
