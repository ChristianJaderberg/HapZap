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
    
    var savedHapZaps = [SongHapZap]()
    
    @IBOutlet weak var hapZapsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTableView()

        // Do any additional setup after loading the view.
    }
    
    func updateTableView() -> Void {
        
        let ref = Database.database().reference()
        ref.child("songhapzaps/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.savedHapZaps.removeAll()
                
                for hapzap in snapshot.children.allObjects as![DataSnapshot] {
                    var hapzapDictionary = hapzap.value as! Dictionary<String, String>
                    hapzapDictionary["firebaseKey"] = hapzap.key
                    let newHapzap = SongHapZap(dictionary: hapzapDictionary)
                    self.savedHapZaps.append(newHapzap)
                }
                
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
        
        tableView.rowHeight = 200
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HapZapTableViewCell
        
        let hapZap = self.savedHapZaps[indexPath.row]
        
        cell.questionLabel.text = hapZap.question
        cell.songTitleLabel.text = hapZap.songName
        
        return cell
    }

}
