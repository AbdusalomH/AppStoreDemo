//
//  ReviewResults.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 20/04/2024.
//

import Foundation

struct ReviewResults: Codable {
    let feed: ReviewFeed
}

struct ReviewFeed: Codable {
    let entry: [Review]
}

struct Review: Codable, Identifiable {
    var id: String { content.label }
    let content: JSONLabel
    let title: JSONLabel
    let author: Author
    
    let rating: JSONLabel
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case content
        
        case rating = "im:rating"
    }
    
//    let im:rating: JSONLabel
}

struct Author: Codable {
    let name: JSONLabel
}

struct JSONLabel: Codable {
    let label: String
}
