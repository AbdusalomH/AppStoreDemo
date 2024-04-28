//
//  Managers.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 25/04/2024.
//

import Foundation

enum DetailsError: Error {
    case FetchDataError
    case InvalidData
    case InvalidURL
}


struct ApiService {
    
    static func fetchJSONAppDetails(trackId: Int) async throws -> AppDetails {
        
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(trackId)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let responseCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= responseCode {
            
            let fetchedData = try JSONDecoder().decode(FetchResults.self, from: data)
            
            if let fetchdata = fetchedData.results.first {
                return fetchdata
            }
        }
        throw DetailsError.InvalidData
    }
    
    
    static func fetchJsonAppResults(appName: String) async throws -> [Result] {
        
        let results: SearchResults = try await decove(urlString: "https://itunes.apple.com/search?term=\(appName)&entity=software")
        return results.results
    }
    
    
    static func fetchJsonReviews(trackId: Int) async throws -> [Review] {
        guard trackId != 0 else {
            throw DetailsError.InvalidURL
        }

        guard let url = URL(string: "https://itunes.apple.com/rss/customerreviews/page=1/id=\(trackId)/sortby=mostrecent/json?l=en&cc=us") else {
            throw DetailsError.InvalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DetailsError.InvalidData
        }

        do {
            let reviews = try JSONDecoder().decode(ReviewResults.self, from: data)
            return reviews.feed.entry
        } catch {
            throw DetailsError.InvalidData
        }
    }

    
    
    static private func decove<T:Codable>(urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw DetailsError.InvalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let responseCode = (response as? HTTPURLResponse)?.statusCode, !(200..<299 ~= responseCode) {
            throw DetailsError.FetchDataError
        }
        
        return try JSONDecoder().decode(T.self, from: data)
        
    }
}
