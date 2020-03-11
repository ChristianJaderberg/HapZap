//
//  ViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-02-28.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class HapZapViewController: UIViewController {
    
    var randomSongController = RandomSongController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomSongController.refresh(question: "How will I die?") { (result) in
            switch result {
            case .success(let randomSongController):
                self.randomSongController = randomSongController
                
                DispatchQueue.main.async {
                    // Update UI
                    print("Question: \"" + self.randomSongController.getQuestion() + "\"")
                    print("HapZapped song: \"\(self.randomSongController.getSongName())\" with \"\(self.randomSongController.getArtistName())\"")
                    print("AlbumImage url: \(self.randomSongController.getAlbumImage(size: 640))")
                }
            case .failure(let error): print("Error \(error)")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
}
