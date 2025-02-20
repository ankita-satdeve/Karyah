//
//  HeaderCard.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct HeaderCard: View {
    @State private var navigateToCreateProject = false
    
    var title: String
    var description: String? = nil
    var buttonText: String? = nil
    var buttonAction: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#C6381E"),
                            Color(hex: "#9E240F")
                        ]),
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                )
                .frame(height: 150)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if let description = description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2) // Allow multi-line description
                }
                
                if buttonAction, let buttonText = buttonText {
                    Button(action: {
                        navigateToCreateProject = true
                    }) {
                        HStack {
                            Text(buttonText)
                                .font(.headline)
                                .fontWeight(.bold)
                            Image(systemName: "plus")
                        }
                        .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .navigationDestination(isPresented: $navigateToCreateProject) {
                        CreateProjectView()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
        
}

#Preview {
    HeaderCard(title: "Create New Project", description: nil, buttonText: nil, buttonAction: false)
}
