//
//  SpotifyAPI.swift
//  HapZap
//
//  Created by mac on 2020-03-10.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

class SpotifyAPI {
    
    var currentToken = SpotifyToken()
    var offset = 0
    var limit = 50
    
    func search(searchString: String, offset: Int, completion: @escaping( Result<SpotifySearchData, Error>) -> Void) {
        
        self.offset = offset
        
        self.getToken() { (result) in
            switch result {
            case .success(let token):
                self.currentToken = token
                
                DispatchQueue.main.async {
                   
                    self.searchTracks(searchString: searchString) { (result) in
                        switch result {
                        case .success(let receivedSearchData):
                            completion(.success(receivedSearchData))
                            
                        case .failure(let error): print("Error \(error)")
                            completion(.failure(error))
                        }
                    }
            
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
        // Start task
        task.resume()
        print("GetToken started")
    }
    
    func searchTracks(searchString: String, completion: @escaping( Result<SpotifySearchData, Error>) -> Void) {
        
        let oathToken = self.currentToken.accessToken
        
        let urlString = "https://api.spotify.com/v1/search?q=\(searchString)&type=track&limit=\(self.limit)&offset=\(self.offset)"
        guard let url: URL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(oathToken)", forHTTPHeaderField: "Authorization")
        
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
                    let searchData = try decoder.decode(SpotifySearchData.self, from: unwrappedData)
                    completion(.success(searchData))
                } catch {
                    print("Unable to parse JSON from SearchData")
                    print(error)
                    print(error.localizedDescription)
                }
            }
        }
        // Start task
        task.resume()
        print("SearchTracks started")
    }
    
}
