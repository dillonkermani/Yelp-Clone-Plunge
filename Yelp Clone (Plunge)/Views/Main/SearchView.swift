//
//  SearchView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        
        @ObservedObject var UIState = UIStateModel()
        
        VStack {
            SnapCarousel(UIState: UIState)
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
