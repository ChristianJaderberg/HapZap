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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchData = self.spotifyAPI.start(searchString: "s")
        
        
        // Do any additional setup after loading the view.
    }
    
    func start() -> Void {
        self.getToken() { (result) in
            switch result {
            case .success(let token):
                self.currentToken = token
                
                DispatchQueue.main.async {
                    print("Token received")
                    self.searchTracks()
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
    
    func getToken(completion: @escaping( Result<SpotifyToken, Error>) -> Void) {
        var token = SpotifyToken()
        
        let clientCredentials = "ZTFkOWRiZjhlZGI2NDk4OWEwYmZkNDZiZTU1ZjM5NWU6MWI0ZDIwYTkyM2YwNDZjNThmNTcwM2Y1ZmEyZDliZGU="

        let urlString = "https://accounts.spotify.com/api/token"
        let bodyUrl = "grant_type=client_credentials"

        guard let url: URL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.addValue("Basic \(clientCredentials)", forHTTPHeaderField: "Authorization")
        request.httpBody = bodyUrl.data(using: String.Encoding.utf8)
        
        // Request
        print("Requesting")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let unwrappedError = error {
                print("Caught error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
                print("Data was found: \(String(data: unwrappedData, encoding: String.Encoding.utf8) ?? "No data was found")")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    token = try decoder.decode(SpotifyToken.self, from: unwrappedData)
                    completion(.success(token))
                } catch {
                    print("Unable to parse JSON")
                }
            }
        }
        // Starta task
        task.resume()
        print("Task started")
    }

    func searchTracks() -> Void {
        
        let oathToken = currentToken.accessToken

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
