//
//  ReviewViewModel.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 27/04/2024.
//

import Foundation

@MainActor
class ReviewsViewModel: ObservableObject {
    
    @Published var entries: [Review] = [Review]()
    @Published var error: Error?
    
    private let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        fetchReviews()
    }
    
    private func fetchReviews() {
        
        Task {
            do {
                self.entries = try await ApiService.fetchJsonReviews(trackId:trackId)
                print(entries)
            } catch {
                self.error = error
                print("failed to get reviews")
            }
        }
    }
}
