//
//  ContentView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        ZStack {
            CustomTabView()
                .preferredColorScheme(.light)
                
        }.onAppear{userVM.listenAuthenticationState()}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
