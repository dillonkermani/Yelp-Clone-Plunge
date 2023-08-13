//
//  PageIntro.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/12/23.
//

import Foundation

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "p2", title: "The Ultimate\n Wellness Ritual.", subTitle: "Find your community and get inspired."),
    .init(introAssetImage: "p1", title: "Take\nThe Plunge", subTitle: "Boost overall health, mental fitness, and recovery."),
    .init(introAssetImage: "p4", title: "Change\nYour Life", subTitle: "Enter your details to register for an account.", displaysAction: true),
]
