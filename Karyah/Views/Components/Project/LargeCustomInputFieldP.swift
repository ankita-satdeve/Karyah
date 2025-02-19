//
//  LargeCustomInputFieldP.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct LargeCustomInputFieldP: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isMultiline {
                    TextEditor(text: $text)
                        .frame(minHeight: 120) // Increased height for better multiline support
                        .padding(5)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                } else {
                    TextField(placeholder, text: $text)
                        .frame(height: 50) // Standard height for single-line input
                        .padding(.horizontal)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }

                Image(systemName: icon)
                    .foregroundColor(Color(.systemGray2))
                    .font(.title2)
                    .padding(.trailing)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
}

#Preview {
    LargeCustomInputFieldP(icon: "pencil", placeholder: "Enter text here", text: .constant("Sample text"), isMultiline: true)
}
