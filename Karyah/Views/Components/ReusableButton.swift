//
//  ReusableButton.swift
//  Demo_Login
//
//  Created by Prance Studio on 11/02/25.
//

import SwiftUI

struct ReusableButton: View {
    let title: String
    let foregroundColor: Color
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#C6381E"),
                            Color(hex: "#9E240F")
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(foregroundColor)
                .cornerRadius(15)
        }
        .disabled(isDisabled)
        .padding(.horizontal, 4)
    }
}
