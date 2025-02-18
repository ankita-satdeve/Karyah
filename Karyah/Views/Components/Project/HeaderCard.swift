//
//  HeaderCard.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct HeaderCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#BD361E"),
                            Color(hex: "#2E0808")
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 150)

            VStack(alignment: .leading, spacing: 8) {
                Text("All Projects")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("The list of projects you have taken so far")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}
