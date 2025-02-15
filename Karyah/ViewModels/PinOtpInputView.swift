//
//  PinOtpInputView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct PinOtpInputView: View {
    @Binding var code: String
    @FocusState private var focusedIndex: Int?
    let length: Int

    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<length, id: \.self) { index in
                TextField("", text: pinBinding(for: index))
                    .frame(width: 50, height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray2), lineWidth: 1)
                    )
                    .keyboardType(.numberPad)
                    .focused($focusedIndex, equals: index)
            }
        }
    }

    // Helper function for binding
    private func pinBinding(for index: Int) -> Binding<String> {
        Binding(
            get: {
                guard index < code.count else { return "" }
                let charIndex = code.index(code.startIndex, offsetBy: index)
                return String(code[charIndex])
            },
            set: { newValue in
                if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
                    if index < code.count {
                        let startIndex = code.index(code.startIndex, offsetBy: index)
                        code.replaceSubrange(startIndex...startIndex, with: newValue)
                    } else {
                        code.append(newValue)
                    }

                    // Move focus to the next field
                    if !newValue.isEmpty, index < length - 1 {
                        focusedIndex = index + 1
                    }
                } else if newValue.isEmpty {
                    // Move to the previous field on delete
                    if index > 0 {
                        focusedIndex = index - 1
                    }
                }
            }
        )
    }
}
