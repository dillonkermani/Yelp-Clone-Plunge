//
//  SearchView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var sharedVM: SharedViewModel
    
    let images = ["vector1", "vector2", "vector3", "vector4"]
        
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
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
                        SearchBar(text: $sharedVM.searchText)
                            .offset(y: -30)
                            .onSubmit {
                                sharedVM.loadImages()
                            }
                        
                        Divider()
                        
                        HStack {
                            Text("Recommended for you")
                            Spacer()
                        }
                        .padding(.leading, 15)
                        .font(.custom("Futura-Bold", size: 20))
                        .foregroundColor(Color("PlungeBlack"))
                    
                        ImagesList()
                        
                    }
                    .padding(.top, 55 + SCREEN_HEIGHT/3.5)
                }
            }
        }
    }
    
    func ImagesList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                if sharedVM.isLoading {
                    
                } else {
                    ForEach(sharedVM.results, id: \.id, content: { result in
                        ImageCard(url: result.urls.small, id: result.id)
                    })
                }
            }.onAppear {
                sharedVM.loadImages()
            }
            .padding(15)
    
        }.statusBarHidden()
    }
    
    
}
