//
//  DatePickerTextField.swift
//  Karyah
//
//  Created by Prance Studio on 18/02/25.
//

import SwiftUI

struct DatePickerTextField: View {
    var placeholder: String
    @Binding var dateString: String
    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                // TextField
                TextField(placeholder, text: $dateString)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .disabled(true) // Prevent manual text input
//                    .padding(.trailing, 60) // Space for the icon
                
                // Calendar icon inside the TextField
                HStack {
                    Spacer()
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar") // 📅 Calendar icon
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove button default styles
                }
            }
//            .padding(.leading, 20)

            // Date picker
            if showDatePicker {
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .frame(width: 300, height: 250)
                    .padding()

                    Button("Done") {
                        dateString = formatDate(selectedDate)
                        showDatePicker = false
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .transition(.opacity)
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
