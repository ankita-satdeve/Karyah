//
//  CategorySelectionView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack() {
            Text("Business Category").font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
                HStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryButton(
                            title: category,
                            isSelected: viewModel.selectedCategory == category,
                            action: { viewModel.selectCategory(category) }
                        )
                    }
                }
                .padding(15) // Add padding inside the rounded rectangle
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .background(Color.white.cornerRadius(12)) // Ensures a white background
                )
            
//            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
