//
//  CategoryButton.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(minWidth: 80, minHeight: 40)
                .padding(.horizontal, 12)
            //                .background(isSelected ? Color.blue : Color.gray)
                .background(
                    isSelected ?
                    AnyView(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(hex: "#C6381E"),
                                Color(hex: "#9E240F")
                            ]),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                    ) :
                        AnyView(Color.gray)
                )
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .frame(height: 40)
    }
}
