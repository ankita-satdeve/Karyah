//
//  CategoryLocationBackground.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct CategoryLocationBackground: View {
    var isSelected: Bool

    var body: some View {
        Group {
            if isSelected {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#C6381E"),
                        Color(hex: "#9E240F")
                    ]),
                    startPoint: .trailing,
                    endPoint: .leading
                )
            } else {
                Color.gray.opacity(0.2)
            }
        }
    }
}
