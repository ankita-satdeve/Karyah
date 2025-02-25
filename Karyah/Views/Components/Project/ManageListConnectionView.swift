//
//  ManageConnectionView.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct ManageListConnectionView: View {
    @StateObject private var viewModel = ConnectionListViewModel()
    @State private var selectedCoAdmins: [Int] = []
    @State private var selectedCoAdminNames: [String] = []
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Co-Admin:")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.isDropdownVisible.toggle()
                        viewModel.fetchManageListConnections()
                    }) {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 8, height: geometry.size.width / 8)
                            .foregroundColor(.primary)
                            .accessibilityLabel("Select Co-Admin")
                    }
                }
                .padding()
                
                if !selectedCoAdmins.isEmpty {
                    Text("Selected: \(selectedCoAdmins)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                if viewModel.isDropdownVisible {
                    ConnectionDropdownView(
                        viewModel: viewModel,
                        selectedCoAdminIds: $selectedCoAdmins,  // ✅ Ensure this exists
                        selectedCoAdminNames: $selectedCoAdminNames, selectedCoAdminPhotos: $selectedCoAdminNames, // ✅ Pass selected names
                        isDropdownVisible: $viewModel.isDropdownVisible
                    )

                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .preferredColorScheme(.light)
    }
    
}
