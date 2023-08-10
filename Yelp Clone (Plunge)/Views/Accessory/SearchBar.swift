//
//  SearchBar.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
        var body: some View {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        NeumorphicStyleTextField(textField: TextField("Search...", text: $text), imageName: "magnifyingglass")
                    }
                }.padding(.top)
                    .padding(.horizontal, 15)
            }.onTapGesture {
                // Dismiss the keyboard when tapped outside the TextField
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
}

struct NeumorphicStyleTextField: View {
    var textField: TextField<Text>
    var imageName: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.darkShadow)
            textField
            }
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color.background)
            .cornerRadius(6)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)

        }
}

extension Color {
    static let lightShadow = Color.white
    static let darkShadow = Color.gray.opacity(0.6)
    static let background = Color.white
    static let neumorphictextColor = Color.gray.opacity(0.6)
}
