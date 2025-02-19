//
//  ConnectionDropdownView.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct ConnectionDropdownView: View {
    @ObservedObject var viewModel: ConnectionViewModel
    @Binding var selectedCoAdminIds: [Int] // Store IDs
    @Binding var selectedCoAdminNames: [String] // Store Names
    @Binding var isDropdownVisible: Bool

    var body: some View {
        VStack {
            TextField("Search Co-Admin", text: $viewModel.searchText, onEditingChanged: { _ in
                viewModel.filterConnections()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.filteredConnections) { connection in
                        Button(action: {
                            if let index = selectedCoAdminIds.firstIndex(of: connection.userId) {
                                // If already selected, remove from both lists
                                selectedCoAdminIds.remove(at: index)
                                selectedCoAdminNames.remove(at: index)
                            } else {
                                // Otherwise, add to both lists
                                selectedCoAdminIds.append(connection.userId)
                                selectedCoAdminNames.append(connection.name)
                            }
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                
                                VStack(alignment: .leading) {
                                    Text(connection.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    if let location = connection.location {
                                        Text(location)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                Spacer()
                                
                                // Show checkmark if selected
                                if selectedCoAdminIds.contains(connection.userId) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
}
