//
//  ViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-02-28.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomSongController = RandomSongController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomSongController.refresh() { (result) in
            switch result {
            case .success(let randomSongController):
                self.randomSongController = randomSongController
                
                DispatchQueue.main.async {
                    // Update UI
                    print("HapZapped song: \"\(randomSongController.getSongName())\" with \"\(randomSongController.getArtistName())\"")
                }
            case .failure(let error): print("Error \(error)")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
}
