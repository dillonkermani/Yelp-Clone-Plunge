//
//  TabPosition.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
