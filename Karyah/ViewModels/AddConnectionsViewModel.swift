//
//  AddConnectionsViewModel.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI
import Combine

class AddConnectionsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var connections: [Connection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func searchConnections() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        let url = URL(string: "https://api.karyah.in/api/connections/search")!
//        let url = URL(string: "https://api.karyah.in/api/connections/search")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Retrieve token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            DispatchQueue.main.async {
                self.errorMessage = "No authentication token found!"
                self.isLoading = false
            }
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: searchText)
        ]
        request.url = urlComponents.url
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.connections = response.users.map {
                    Connection(
                        id: $0.id,
                        name: $0.name,
                        email: $0.email,
                        phone: $0.phone,
                        location: $0.location,
                        bio: $0.bio,
                        dob: $0.dob,
                        pin: $0.pin,
                        profilePhoto: $0.profilePhoto,
                        createdAt: $0.createdAt,
                        updatedAt: $0.updatedAt
                        )
                }
            })
            .store(in: &cancellables)
    }
}

struct SearchResponse: Codable {
    let users: [Connection]
    
    
    struct User: Codable {
        let userId: Int
        let name: String
        let email: String
        let phone: String
        let location: String
        let bio: String
        let dob: String
        let pin: String
        let profilePhoto: String
        let createdAt: String
        let updatedAt: String
    }
}
