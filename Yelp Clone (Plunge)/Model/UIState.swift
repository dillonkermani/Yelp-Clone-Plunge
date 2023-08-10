//
//  UIState.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import Foundation

public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}
