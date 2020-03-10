//
//  SpotifyToken.swift
//  HapZap
//
//  Created by mac on 2020-03-10.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct SpotifyToken: Codable {
    let accessToken: String
    
    init() {
        self.accessToken = ""
    }
}
