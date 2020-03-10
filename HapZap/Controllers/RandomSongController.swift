//
//  RandomSongController.swift
//  HapZap
//
//  Created by mac on 2020-03-10.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

class RandomSongController {
    
    let spotifyAPI = SpotifyAPI()
    var currentSearchData = SpotifySearchData()
    
    var currentSearchString = ""
    var currentOffset = 0
    var currentTrackIndex = 0
    
    func refresh(completion: @escaping( Result<RandomSongController, Error>) -> Void) {
        
        // Generate random values to use for the search
        self.randomizer()
        
        // Perform search
        self.spotifyAPI.search(searchString: self.currentSearchString, offset: self.currentOffset) { (result) in
            switch result {
            case .success(let searchData):
                self.currentSearchData = searchData
                
                DispatchQueue.main.async {
                    print("Searchdata received in randomsongcontroller")
                    print("length of items:" + String(self.currentSearchData.tracks.items.count))
                    completion(.success(self))
                }
            case .failure(let error): print("Error \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func randomizer() -> Void {
        
        // Set random searchString
        let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        let randomCharacter = letters[Int.random(in: 0..<letters.count)]
        self.currentSearchString = randomCharacter
        
        // Set random offset
        self.currentOffset = Int.random(in: 0...2000)
        
    }
    
    func getArtistName() -> String {
        return self.currentSearchData.tracks.items[self.currentTrackIndex].artists[0].name
    }
    
    func getSongName() -> String {
        return self.currentSearchData.tracks.items[self.currentTrackIndex].name
    }
    
}
