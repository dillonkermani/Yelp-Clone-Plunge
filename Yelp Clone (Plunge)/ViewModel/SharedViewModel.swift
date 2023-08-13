//
//  SharedViewModel.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/10/23.
//

import Foundation

class SharedViewModel: ObservableObject {
    
    @Published var results: [Result] = []
    @Published var urls: [String] = []
    @Published var isLoading = false
    @Published var searchText = "Plunge"
    
    func loadImages() {
        self.isLoading = true
        UnsplashAPI().search(searchText: self.searchText) { results in
                DispatchQueue.main.async {
                    self.results = results
                    self.isLoading = false
                }
            }
    }
    
    
    
}
