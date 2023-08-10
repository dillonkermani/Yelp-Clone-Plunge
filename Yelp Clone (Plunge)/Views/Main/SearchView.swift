//
//  SearchView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        
        let images = ["vector1", "vector2", "vector3", "vector4"]
                
        VStack {
            
            GeometryReader { geometry in
                ImageCarouselView(numberOfImages: 4) {
                    ForEach(0..<4) { i in
                        Image("\(images[i])")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }.clipped()
            }.frame(width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3.5)
            
            ScrollView {
                VStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                }
            }
            
            
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
