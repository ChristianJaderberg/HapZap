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
    var artistName: String
    var imageURL: String
    var trackURI: String
    var firebaseKey: String
    
    init() {
        self.question = ""
        self.songName = ""
        self.artistName = ""
        self.imageURL = ""
        self.trackURI = ""
        self.firebaseKey = ""
    }
    
    init(dictionary: Dictionary<String, String>) {
        self.question = dictionary["question"]!
        self.songName = dictionary["songName"]!
        self.artistName = dictionary["artistName"]!
        self.imageURL = dictionary["imageURL"]!
        self.trackURI = dictionary["trackURI"]!
        self.firebaseKey = dictionary["firebaseKey"]!
    }
    
    func getAsDictionary() -> Dictionary<String, String> {
        return ["question":self.question,
                "songName":self.songName,
                "artistName":self.artistName,
                "imageURL":self.imageURL,
                "trackURI":self.trackURI,
                "firebaseKey":self.firebaseKey]
    }
    
}
