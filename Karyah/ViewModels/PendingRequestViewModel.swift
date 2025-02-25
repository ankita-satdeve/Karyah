//
//  PendingRequestViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

import SwiftUI
import Combine

class PendingRequestViewModel: ObservableObject {
    @Published var pendingRequests: [PendingRequest] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPendingRequests() {
        guard let url = URL(string: "\(ConnectionBaseURL.url)/pending-requests") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(TokenStorage.token)", forHTTPHeaderField: "Authorization")
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: PendingRequestResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to load pending requests: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.pendingRequests = response.pendingRequests
            })
            .store(in: &cancellables)
    }
}
