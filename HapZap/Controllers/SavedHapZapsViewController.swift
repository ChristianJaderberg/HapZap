//
//  SavedHapZapsViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-16.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SavedHapZapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = Database.database().reference()
    var savedHapZaps = [SongHapZap]()
    var switchCellBGColor = true
    var tableViewRowHeight: CGFloat = 420
    
    @IBOutlet weak var hapZapsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTableView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.updateTableView()
    }
    
    func updateTableView() -> Void {
        
        self.ref.child("songhapzaps/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.savedHapZaps.removeAll()
                
                for hapzap in snapshot.children.allObjects as![DataSnapshot] {
                    // save hapzap-data as dictionary
                    var hapzapDictionary = hapzap.value as! Dictionary<String, String>
                    // add hapzap-key to dictionary
                    hapzapDictionary["firebaseKey"] = hapzap.key
                    // create hapzap-object with dictionary
                    let newHapzap = SongHapZap(dictionary: hapzapDictionary)
                    // save hapzap-object in array
                    self.savedHapZaps.append(newHapzap)
                }
                
                // reverse the HapZaps to bring the last saved on top
                self.savedHapZaps.reverse()
                
                self.hapZapsTableView.reloadData()
            }
            
          }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedHapZaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = self.tableViewRowHeight
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HapZapTableViewCell
        
        let hapZap = self.savedHapZaps[indexPath.row]
        
        cell.delegate = self
        cell.setHapZap(hapzap: hapZap)
        
        cell.questionLabel.text = hapZap.question
        cell.songNameLabel.text = hapZap.songName
        cell.artistNameLabel.text = hapZap.artistName.uppercased()
        
        // set albumimage
        let url = hapZap.imageURL
        guard let imageURL = URL(string: url) else { return cell }
        cell.albumImageView.downloadImage(from: imageURL)
        /*
        if switchCellBGColor {
            cell.cellContentView.backgroundColor = UIColor(red:0.90, green:0.79, blue:0.89, alpha:1.00)
            self.switchCellBGColor = false
        } else {
            cell.cellContentView.backgroundColor = UIColor(red:0.85, green:0.70, blue:0.83, alpha:1.00)
            self.switchCellBGColor = true
        }
        */
 
        return cell
    }
    
    // swipe left to remove HapZap
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let hapZap = self.savedHapZaps[indexPath.row]
        
        self.ref.child("songhapzaps/").child(hapZap.firebaseKey).removeValue(completionBlock: {(error, ref) in
            
            if error != nil {
                print("Failed to remove hapzap", error!)
                return
            }
            
            print("hapzap was removed")
            self.updateTableView()
            
        })
    }

}

extension UIViewController: HapZapTableViewCellDelegate {
    
    func didTapPlayInSpotifyButton(spotifyURI: String) {
        if let url = URL(string: spotifyURI) {
            UIApplication.shared.open(url)
        }
    }
    
}
