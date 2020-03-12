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
    var currentSongHapZap = SongHapZap()
    
    var currentSearchString = ""
    var currentOffset = 0
    var currentTrackIndex = 0
    
    func refresh(question: String, completion: @escaping( Result<RandomSongController, Error>) -> Void) {
        
        // Generate random values to use for the search
        self.randomizer()
        
        // Perform search
        self.spotifyAPI.search(searchString: self.currentSearchString, offset: self.currentOffset) { (result) in
            switch result {
            case .success(let searchData):
                self.currentSearchData = searchData
                
                // Save searchData in SongHapZap-object
                self.currentSongHapZap.question = question
                self.currentSongHapZap.songName = self.currentSearchData.tracks.items[self.currentTrackIndex].name
                self.currentSongHapZap.artists =  self.currentSearchData.tracks.items[self.currentTrackIndex].artists
                self.currentSongHapZap.images = self.currentSearchData.tracks.items[self.currentTrackIndex].album.images
                self.currentSongHapZap.trackURI = self.currentSearchData.tracks.items[self.currentTrackIndex].uri
                
                DispatchQueue.main.async {
                    print("Searchdata received in randomsongcontroller")
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
    
    func getQuestion() -> String {
        return self.currentSongHapZap.question
    }
    
    func getSongName() -> String {
        return self.currentSongHapZap.songName
    }
    
    func getArtistName() -> String {
        return self.currentSongHapZap.artists[0].name
        // TODO fix if multiple names
    }
    
    func getAlbumImage(size: Int) -> String {
        
        let images = self.currentSongHapZap.images
        
        for i in images {
            if (size == i.width) {
                return i.url
            }
        }
        
        return "No image was found"
    }
    
    func getTrackURI() -> String {
        return self.currentSongHapZap.trackURI
    }
    
}
