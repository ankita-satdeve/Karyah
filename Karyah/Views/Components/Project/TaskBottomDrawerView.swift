//
//  TaskBottomDrawerView.swift
//  Karyah
//
//  Created by Prance Studio on 21/02/25.
//

import SwiftUI

struct TaskBottomDrawerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToCreateTask = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 15) {
                    HStack {
                        Image("changePin")
                        Text("Create New Task")
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image("close")
                                .background(Color(hex: "ECEFFF"))
                                .clipShape(Circle())
                        }
                    }
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                    
                    CustomInputFieldProjectName(icon: "", placeholder: "Task Name", text: .constant(""))
                        .padding(.vertical)
                    
                    LargeCustomInputFieldP(icon: "", placeholder: "Description", text: .constant(""))
                }
                .padding()

                ReusableButton(
                    title: "Continue",
                    foregroundColor: .white,
                    isDisabled: false,
                    action: {
                        // Handle continue action
                    }
                )

                HStack {
                    Text("Want to Add Complete Details? ")
                        .foregroundColor(Color(.systemGray3))

                    Button(action: { navigateToCreateTask = true }) {
                        Text("Click Here")
                            .foregroundColor(.blue)
                    }
                }
                .bold()

                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .navigationDestination(isPresented: $navigateToCreateTask) {
                CreateProjectView()  // Replace with TaskView()
            }
        }
    }
}
