//
//  ViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-02-28.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentToken = SpotifyToken()
    
    let spotifyAPI = SpotifyAPI()
    var currentSearchData = SpotifySearchData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spotifyAPI.search(searchString: "d", offset: 100) { (result) in
            switch result {
            case .success(let searchData):
                self.currentSearchData = searchData
                
                DispatchQueue.main.async {
                    print("Searchdata received in viewcontroller")
                    print("length of items:" + String(self.currentSearchData.tracks.items.count))
                    print(self.currentSearchData.tracks.items[2].name)
                    print(self.currentSearchData.tracks.items[7].artists[0])
                }
            case .failure(let error): print("Error \(error)")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
}
