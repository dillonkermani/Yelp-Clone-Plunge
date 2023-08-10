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
        
        @State var searchText = ""
                
        ZStack {
            ScrollView {
                ZStack {
                    VStack {
                        Group {

                            HStack {
                                Text("Take the Plunge.")
                                Spacer()
                            }
                            HStack {
                                Text("Change your life.")
                                Spacer()
                            }
                            .padding(.leading, 25)
                        }
                        .padding(.leading, 25)
                        .font(.custom("Futura-Bold", size: 27))
                        .foregroundColor(Color("PlungeBlack"))

                        
                        Spacer()
                    }
                   
                    
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
                        
                        Spacer()
                        
                    }.padding(.top, 65)
                    
                    VStack {
                        SearchBar(text: searchText)
                            .offset(y: -30)
                    }
                    .padding(.top, 55 + SCREEN_HEIGHT/3.5)
                    
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
