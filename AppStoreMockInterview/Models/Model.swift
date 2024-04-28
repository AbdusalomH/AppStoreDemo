//
//  AppStoreModel.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 17/04/2024.
//

import Foundation

struct SearchResults: Codable {
    let results: [Result]
}

struct Result: Codable, Identifiable {
    
    var id: Int { trackId }
    
    let trackId: Int
    let trackName: String
    let artworkUrl512: String
    let primaryGenreName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let userRatingCount: Int
}

struct FetchResults: Codable {
    let resultCount: Int
    let results: [AppDetails]
}

struct AppDetails: Codable {
    let trackName: String
    let description: String
    let artworkUrl512: String
    let screenshotUrls: [String]
    let releaseNotes: String
    let primaryGenreName: String
}



