//
//  AppDetailViewModel.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 25/04/2024.
//

import Foundation

@MainActor
class AppDetailViewModel: ObservableObject {
    
    @Published var fetchdetails: AppDetails?
    @Published var error: Error?
    
    private let trackId: Int
    
    init(trackId: Int) {
        self.trackId = trackId
        fetchJSONData()
    }
    
    private func fetchJSONData() {
        print("trackID \(trackId)")
        Task {
            do {
                self.fetchdetails = try await ApiService.fetchJSONAppDetails(trackId: trackId)
            } catch {
                self.error = error
            }
        }
    }
}
