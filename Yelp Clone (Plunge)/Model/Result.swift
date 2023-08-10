//
//  Result.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/10/23.
//

import Foundation

struct Results: Codable {
    var total: Int
    var results: [Result]
}

struct Result: Codable {
    var id: String
    var description: String?
    var urls: URLs
}

struct URLs: Codable {
    var small: String
}
