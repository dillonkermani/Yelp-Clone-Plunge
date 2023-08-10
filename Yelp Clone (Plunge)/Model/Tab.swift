//
//  Tab.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case search = "Search"
    case projects = "Projects"
    case me = "Me"
    case collections = "Collections"
    case more = "More"
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .projects:
            return "square.grid.3x1.folder.badge.plus"
        case .me:
            return "person.circle"
        case .collections:
            return "bookmark"
        case .more:
            return "line.3.horizontal"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
