//
//  User.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/11/23.
//

import Foundation

struct User: Encodable, Decodable, Hashable {
    // Profile Data
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    
    // Optional Data
    var savedPhotos: [String]?
}

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.secondsSince1970
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.secondsSince1970
        self = try decoder.decode(Self.self, from: data)
    }
}
