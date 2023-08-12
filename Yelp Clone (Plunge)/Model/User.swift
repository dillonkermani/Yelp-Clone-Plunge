//
//  User.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/11/23.
//

import Foundation

struct User: Encodable, Decodable {
    // Profile Data
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    
    // Optional Data
    var savedPhotos: [String]?
}
