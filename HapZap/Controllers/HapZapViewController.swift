//
//  ViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-02-28.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HapZapViewController: UIViewController, UITextFieldDelegate {
    
    var randomSongController = RandomSongController()
    var initQuestion = ""
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapZap(question: self.initQuestion)
        
        // code needed for hiding keyboard when enter is pressed
        self.questionTextField.delegate = self
    }
    
    // hide keyboard when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func hapZapButtonTapped(_ sender: Any) {
        
        if (self.questionTextField.text != "") {
            hapZap(question: self.questionTextField.text!)
            
            // hide keyboard
            self.questionTextField.resignFirstResponder()
            
            // clear textfield
            self.questionTextField.text = ""
        } else {
            // create and show alert message
            let alert : UIAlertController = UIAlertController(title: "No input!", message: "Please enter a HapZap-question", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func saveHapZapButtonTapped(_ sender: Any) {
        
        let ref = Database.database().reference()
        let data = self.randomSongController.currentSongHapZap.getAsDictionary()
        ref.child("songhapzaps/").childByAutoId().setValue(data, withCompletionBlock: { err, ref in
            if let error = err {
                print("HapZap was not saved: \(error.localizedDescription)")
            } else {
                print("HapZap saved successfully!")
            }
        })
        
    }
    
    @IBAction func playInSpotifyButtonTapped(_ sender: Any) {
        if let url = URL(string: self.randomSongController.getTrackURI()) {
            UIApplication.shared.open(url)
        }
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
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
    
    func updateHapZapUI() -> Void {
        self.setAlbumImage()
        self.questionLabel.text = self.randomSongController.getQuestion()
        self.songNameLabel.text = self.randomSongController.getSongName()
        self.artistNameLabel.text = self.randomSongController.getArtistName().uppercased()
    }
    
    func setAlbumImage() {
        let url = self.randomSongController.getAlbumImage()
        guard let imageURL = URL(string: url) else { return }
        self.albumImageView.downloadImage(from: imageURL)
    }

}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else { return }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
