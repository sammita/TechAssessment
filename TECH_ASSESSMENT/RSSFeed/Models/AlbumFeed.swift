//
//  AlbumFeed.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 12/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

///Model object for the iTunes Top Albums

import UIKit

// MARK: - RssFeed
struct AlbumFeed: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let title: String
    let id: String
    let results: [Album]
}

// MARK: - Album Details
struct Album: Codable {
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let copyright: String
    let artistId: String
    let artistUrl: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

// MARK: - Genre Details
struct Genre: Codable {
    let genreId: String
    let name: String
    let url: String
}
