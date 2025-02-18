//
//  CreateProjectListViewModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import Foundation
import Combine

class ProjectListViewModel: ObservableObject {
    @Published var projects: [ProjectModel] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchProjects()
    }

    func fetchProjects() {
        guard let url = URL(string: "https://api.karyah.in/api/projects/") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenStorage.token)", forHTTPHeaderField: "Authorization")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601  // Ensures date parsing works

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [String: [ProjectModel]].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to load projects: \(error.localizedDescription)"
                    print("Decoding error: \(error)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { result in
                self.projects = result["projects"] ?? []
            })
            .store(in: &cancellables)
    }


    var filteredProjects: [ProjectModel] {
        guard !searchText.isEmpty else { return projects }
        return projects.filter { $0.projectName.localizedCaseInsensitiveContains(searchText) }
    }
}
