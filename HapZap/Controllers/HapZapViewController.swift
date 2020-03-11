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
    var initQuestion = ""
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapZap(question: self.initQuestion)
    }
    
    @IBAction func hapZapButtonPressed(_ sender: Any) {
    }
    
    func hapZap(question: String) -> Void {
        randomSongController.refresh(question: question) { (result) in
            switch result {
            case .success(let randomSongController):
                self.randomSongController = randomSongController
                
                DispatchQueue.main.async {
                    // Update UI
                    self.updateHapZapUI()
                    print("Question: \"" + self.randomSongController.getQuestion() + "\"")
                    print("HapZapped song: \"\(self.randomSongController.getSongName())\" with \"\(self.randomSongController.getArtistName())\"")
                    print("AlbumImage url: \(self.randomSongController.getAlbumImage(size: 640))")
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
    
    func updateHapZapUI() -> Void {
        self.questionLabel.text = self.randomSongController.getQuestion()
        self.songNameLabel.text = self.randomSongController.getSongName()
        self.artistNameLabel.text = self.randomSongController.getArtistName()
    }
    
}
