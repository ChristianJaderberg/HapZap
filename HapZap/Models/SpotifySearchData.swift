//
//  SpotifySearchData.swift
//  HapZap
//
//  Created by mac on 2020-03-10.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct SpotifySearchData: Codable {
    let tracks: Tracks
    
    init() {
        self.tracks = Tracks()
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let items: [Item]
    let offset: Int
    let total: Int
    
    init() {
        self.items = [Item]()
        self.offset = 0
        self.total = 0
    }
}

// MARK: - Item
struct Item: Codable {
    let artists: [Artist]
    let album: Album
    let href: String
    let id: String
    let name: String
    let uri: String
}

// MARK: - Artist
struct Artist: Codable {
    let name: String
}

// MARK: - Album
struct Album: Codable {
    let images: [Image]
}

// MARK: - Image
struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}
