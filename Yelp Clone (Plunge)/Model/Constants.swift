//
//  Constants.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI
import FirebaseFirestore

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width

class Ref {
    // Firestore
    static var FIRESTORE_ROOT = Firestore.firestore()

    // Firestore - Users
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(uid: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(uid)
    }
}
