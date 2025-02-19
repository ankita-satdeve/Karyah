//
//  ManageConnectionView.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import SwiftUI

struct ManageConnectionView: View {
    @StateObject private var viewModel = ConnectionViewModel()
    @State private var selectedCoAdmin = ""
    
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
                        viewModel.fetchManageConnections()
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
                
                if !selectedCoAdmin.isEmpty {
                    Text("Selected: \(selectedCoAdmin)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                if viewModel.isDropdownVisible {
                    ConnectionDropdownView(viewModel: viewModel, selectedName: $selectedCoAdmin, isDropdownVisible: $viewModel.isDropdownVisible)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .preferredColorScheme(.light)
    }
    
}
