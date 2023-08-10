//
//  UnsplashAPI.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/10/23.
//

import Foundation

class UnsplashAPI {
    
    var ACCESS_KEY = "mM-N7n43DUlCaZ2jBCW1eJhHwuWRci5MAcHj8IquzQU"    
    
    func search(searchText: String, onSuccess: @escaping(_ results: [Result]) -> Void) {
        if searchText.isEmpty {
            print("SearchText is Empty")
            return
        }
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText.replacingOccurrences(of: " ", with: ""))")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(ACCESS_KEY)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                print(res)
                onSuccess(res.results)
            } catch {
                print(error)
                print("Data: \(data)")
            }
        }
        task.resume()
    }
    
}
