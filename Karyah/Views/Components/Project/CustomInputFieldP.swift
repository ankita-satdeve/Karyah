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
    var options: [String]?
    
    @State private var showDropdown = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                showDropdown.toggle()
            }) {
                HStack {
                    Text(text.isEmpty ? placeholder : text)
                        .foregroundColor(text.isEmpty ? Color(.systemGray2) : .primary)
                    Spacer()
                    if let _ = options {
                        Image(systemName: icon)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }

            if showDropdown, let options = options {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            text = option  // Update viewModel property
                            showDropdown = false
                        }) {
                            Text(option)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                        }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
        }
    }
}


//struct CustomInputFieldP: View {
//    var icon: String
//    var placeholder: String
//    @Binding var text: String
//    var isMultiline: Bool = false
//
//    var body: some View {
//        HStack {
//            if isMultiline {
//                TextEditor(text: $text)
//                    .frame(height: 60)
//            } else {
//                TextField(placeholder, text: $text)
//            }
//            
//            Image(systemName: icon)
//                .foregroundColor(Color(.systemGray2))
//                .fontWeight(.bold)
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//    }
//}
