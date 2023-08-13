//
//  SavedView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/12/23.
//

import SwiftUI

struct SavedView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack {
            ImagesList()
        }.onAppear {
            userVM.loadUser(uid: userVM.user.uid)
        }
    }
    
    func ImagesList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(userVM.user.savedPhotos ?? [], id: \.self, content: { url in
                    ImageCard(url: url)
                })
            }
            .padding(15)
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
