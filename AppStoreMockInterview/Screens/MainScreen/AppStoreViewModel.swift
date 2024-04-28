//
//  AppStoreViewModel.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 27/04/2024.
//

import Foundation
import Combine

@MainActor
class AppStoreModel: ObservableObject {
    
    @Published var results: [Result] = [Result]()
    @Published var searchString: String = "Snapchat"
    @Published var isSearching = false
    @Published var error: Error?

    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        $searchString
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self else {return}
                self.fetchJSONData(newValue: newValue)
            }.store(in: &cancelables)
    }
    
    private func fetchJSONData(newValue: String) {
        
        Task {
            do {
                self.results = try await ApiService.fetchJsonAppResults(appName: searchString)
            } catch {
                self.error = error
            }
        }
    }
}
