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
    @Published var project: ProjectDetailModel?
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var isNavigatingToDetails = false

    private var cancellables = Set<AnyCancellable>()

        let apiUrl = "\(BaseURL.url)/projects"
    
    init() {
        fetchProjects()
    }
    
    func fetchProjects() {
        guard let url = URL(string: "\(apiUrl)/") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("Token not found")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

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

    
    func fetchProject(by id: String) {
        guard let url = URL(string: "\(apiUrl)/\(id)") else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            guard let token = UserDefaults.standard.string(forKey: "userToken") else {
                print("Token not found")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ProjectResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to load project: \(error.localizedDescription)"
                    print("Decoding error: \(error)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { result in
                self.project = result.project  // ✅ Assign correctly now
            })
            .store(in: &cancellables)
        }

    var filteredProjects: [ProjectModel] {
        guard !searchText.isEmpty else { return projects }
        return projects.filter { $0.projectName.localizedCaseInsensitiveContains(searchText) }
    }
}
