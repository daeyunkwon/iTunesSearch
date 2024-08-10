//
//  Software.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import Foundation

struct SoftwareResult: Decodable {
    let results: [Software]
}

struct Software: Decodable {
    let artworkUrl60: String
    let artworkUrl100: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let releaseNotes: String
    let description: String
    let trackName: String
    let trackId: Int
    let sellerName: String
    let genres: [String]
}
