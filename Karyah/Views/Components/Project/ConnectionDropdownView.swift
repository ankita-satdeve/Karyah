//
//  ConnectionDropdownView.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct ConnectionDropdownView: View {
    @ObservedObject var viewModel: ConnectionViewModel
    @Binding var selectedName: String
    @Binding var isDropdownVisible: Bool
    
    var body: some View {
        VStack {
            TextField("Search Co-Admin", text: $viewModel.searchText, onEditingChanged: { _ in
                viewModel.filterConnections()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .accessibilityLabel("Search Co-Admin")
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.filteredConnections) { connection in
                        Button(action: {
                            selectedName = connection.name
                            isDropdownVisible = false
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                    .accessibilityHidden(true)
                                
                                VStack(alignment: .leading) {
                                    Text(connection.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .accessibilityLabel(connection.name)
                                    
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
//        .padding()
    }
}
