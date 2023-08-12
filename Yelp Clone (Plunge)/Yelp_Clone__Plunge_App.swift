//
//  Yelp_Clone__Plunge_App.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI


@main
struct Yelp_Clone__Plunge_App: App {
    
    @StateObject var userVM = UserViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userVM)
                .preferredColorScheme(.light)
        }
    }
}
