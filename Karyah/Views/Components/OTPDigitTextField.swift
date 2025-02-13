//
//  OTPDigitTextField.swift
//  Demo_Login
//
//  Created by Prance Studio on 12/02/25.
//

import SwiftUI

struct OTPDigitTextField: View {
    let index: Int
    @Binding var otp: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: Binding(
            get: {
                if index < otp.count {
                    let charIndex = otp.index(otp.startIndex, offsetBy: index)
                    return String(otp[charIndex])
                } else {
                    return ""
                }
            },
            set: { newValue in
                if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
                    if index < otp.count {
                        let startIndex = otp.index(otp.startIndex, offsetBy: index)
                        otp.replaceSubrange(startIndex...startIndex, with: newValue)
                    } else {
                        otp.append(newValue)
                    }
                    if newValue.count == 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.isFocused = false
                        }
                    }
                }
            }
        ))
        .focused($isFocused)
        .onChange(of: isFocused) { oldValue, newValue in
            if newValue && index >= otp.count {
                otp.append("")
            }
        }
        
    }
}
