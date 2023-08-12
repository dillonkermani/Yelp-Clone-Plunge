//
//  LoginView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/11/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        @Environment(\.presentationMode) var presentationMode

        
        VStack {
            Spacer()
            HStack {
                Text("Login")
                Spacer()
            }
            Spacer()
        }.background(.white)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
