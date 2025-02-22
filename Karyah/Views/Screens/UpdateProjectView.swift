//
//  UpdateProjectView.swift
//  Karyah
//
//  Created by Prance Studio on 22/02/25.
//

import SwiftUI

struct UpdateProjectView: View {
    @State var project: ProjectDetailModel
    @ObservedObject var viewModel: ProjectListViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section(header: Text("Project Details")) {
                TextField("Project Name", text: $project.projectName)
                TextField("Location", text: Binding(
                    get: { project.location ?? "" },
                    set: { project.location = $0.isEmpty ? nil : $0 }
                ))
                TextField("Description", text: Binding(
                    get: { project.description ?? "" },
                    set: { project.description = $0.isEmpty ? nil : $0 }
                ))
            }

            Button("Save Changes") {
                viewModel.updateProject(project) {
                    dismiss() // Close view after successful update
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Edit Project")
    }
}
