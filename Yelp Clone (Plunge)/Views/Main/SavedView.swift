//
//  SavedView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/12/23.
//

import SwiftUI

struct SavedView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if userVM.isLoggedIn {
            VStack {
                
                HStack {
                    Text("Saved Photos")
                    Spacer()
                }
                .padding(.leading, 25)
                .font(.custom("Futura-Bold", size: 27))
                .foregroundColor(Color("PlungeBlack"))
                
                
                ImagesList()
                    .padding()
                
                Spacer()
            }.onAppear {
                userVM.loadUser(uid: userVM.user.uid)
            }
        }
    }
    
    func ImagesList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridItems, alignment: .leading, spacing: 15) {
                ForEach(userVM.user.savedPhotos ?? [], id: \.self) { url in
                    ImageCard(url: url)
                }
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
