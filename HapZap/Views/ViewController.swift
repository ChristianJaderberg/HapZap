//
//  ViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-02-28.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search()
        // Do any additional setup after loading the view.
    }


    func search() -> Void {
        let oathToken = "BQBSq3NKQjt6l1vdB9eGYQ1jVlMC1RE7AGHLieDFPfTIE06j5KMW2I4z9HNsRSgg0D1pfPlpKq7B4tK2hRegSATW7NwH9aW7xrJloVgmSi6Bh6KRMHnTvTVz63n0q6q_b1jX-H3LQZcHQgTh5Q"

        let url = URL(string: "https://api.spotify.com/v1/search?q=s&type=track&offset=5")

        var request = URLRequest(url: url!)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(oathToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }

            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }

        task.resume()
    }
    
}

