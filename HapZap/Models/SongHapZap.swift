//
//  SongHapZap.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-11.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct SongHapZap {
    
    var question: String
    var songName: String
    var artists: [Artist]
    var images: [Image]
    
    init() {
        self.question = ""
        self.songName = ""
        self.artists = []
        self.images = []
    }
    
}
