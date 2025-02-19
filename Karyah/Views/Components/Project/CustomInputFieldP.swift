//
//  CustomInputFieldP.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct CustomInputFieldP: View {
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
