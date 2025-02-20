//
//  CustomInputFieldProjectName.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct CustomInputFieldProjectName: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        HStack {
            if isMultiline {
                TextEditor(text: $text)
                    .frame(height: 60)
            } else {
                TextField(placeholder, text: $text)
            }

            Image(systemName: icon)
                .foregroundColor(Color(.systemGray2))
                .fontWeight(.bold)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}
