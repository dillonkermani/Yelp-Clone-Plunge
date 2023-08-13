//
//  LoginViewModel.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/12/23.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    
    var errorString = ""
    var authResultString = ""
    
    
    func signin(onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                guard let userId = authData?.user.uid else { return }
                
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(uid: userId)
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decoderUser = try? User.init(from: dict as! Decoder) else {return}
                        onSuccess(decoderUser)
                    }
                }
            }
  
       }
    
    
    func signup(onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: self.password) { (authData, error) in
                    if error != nil {
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    guard let userId = authData?.user.uid else { return }
                                        
                    let userRef = Ref.FIRESTORE_DOCUMENT_USERID(uid: userId)
                                  
                    // Add user to Firebase/users
                    let user = User.init(uid: userId,
                                         firstName: self.firstName,
                                         lastName: self.lastName,
                                         email: self.email,
                                         savedPhotos: [])
                                                            
                    guard let dict = try? user.toDictionary() else {return}

                    userRef.setData(dict) { (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                        onSuccess(user)
                    }
 
                }
    }
    
    func clear() {
        firstName = ""
        lastName = ""
        phone = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
}
