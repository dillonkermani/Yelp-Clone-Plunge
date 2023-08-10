//
//  ProjectsView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct ProjectsView: View {
    
    let images = ["vector1", "vector2", "vector3", "vector4"]

    var body: some View {
        VStack {
            TabView{
                ForEach(0..<4) { i in
                    Image("\(images[i])")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 800)
                }
            }.tabViewStyle(PageTabViewStyle())
            //.ignoresSafeArea()
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
