//
//  ConnectionDropdownView.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct ConnectionDropdownView: View {
    @ObservedObject var viewModel: ConnectionListViewModel
    @Binding var selectedCoAdminIds: [Int]
    @Binding var selectedCoAdminNames: [String]
    @Binding var selectedCoAdminPhotos: [String]
    @Binding var isDropdownVisible: Bool

    var body: some View {
        VStack {
            ForEach(viewModel.filteredConnections, id: \.userId) { connection in // ✅ Ensure uniqueness
                HStack {
                    AsyncImage(url: URL(string: connection.profilePhoto ?? "")) { imagePhase in
                        if let image = imagePhase.image {
                            image.resizable().scaledToFill()
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
                    Text(connection.name)
                        .font(.body)

                    Spacer()
                    
                    let isSelected = selectedCoAdminIds.contains(connection.userId)
                    
                    Button(action: {
                        if isSelected {
                            if let index = selectedCoAdminIds.firstIndex(of: connection.userId) {
                                selectedCoAdminIds.remove(at: index)
                                selectedCoAdminNames.remove(at: index)
                                selectedCoAdminPhotos.remove(at: index)
                            }
                        } else {
                            selectedCoAdminIds.append(connection.userId)
                            selectedCoAdminNames.append(connection.name)
                            selectedCoAdminPhotos.append(connection.profilePhoto ?? "")
                        }
                    }) {
                        Image(systemName: isSelected ? "minus.circle.fill" : "plus.circle.fill")
                            .foregroundColor(isSelected ? .red : .blue)
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}
