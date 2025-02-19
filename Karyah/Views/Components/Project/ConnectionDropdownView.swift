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
                            if !selectedCoAdminIds.contains(connection.userId) {
                                selectedCoAdminIds.append(connection.userId) // Store ID
                                selectedCoAdminNames.append(connection.name) // Store Name
                            }
                            isDropdownVisible = false
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
