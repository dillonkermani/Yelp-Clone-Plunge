//
//  MeView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct MeView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack {
            if userVM.isLoggedIn {
                Text("Welcome \(userVM.user.firstName)")
                Button {
                    userVM.logout()
                } label: {
                    Text("Logout")
                }
            }

        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
