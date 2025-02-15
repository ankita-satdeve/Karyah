//
//  LocationSelectionView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct LocationSelectionView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack() {
            Text("Preferred Location").font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image(systemName: "location.fill")
                Text("Choose from location")
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ForEach(viewModel.locations, id: \.self) { location in
                    CategoryButton(
                        title: location,
                        isSelected: viewModel.selectedLocation == location,
                        action: { viewModel.selectLocation(location) }
                    )
                }
            }
            .padding(15) // Add padding inside the rounded rectangle
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                    .background(Color.white.cornerRadius(12)) // Ensures a white background
                    .background(Color(.systemGray6))
            )
            
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
}
