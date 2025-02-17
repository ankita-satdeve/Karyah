//
//  CustomTextField.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(height: 50)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray2), lineWidth: 1)
            )
            .keyboardType(.default)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .focused($isFocused)
    }
}


//struct CustomTextField: View {
//    var placeholder: String
//    @Binding var text: String
//
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
//    }
//}
