//
//  TabView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct CustomTabView: View {

    @State private var activeTab: Tab = .search
    @State private var promptLogin = false
    /// For Smooth Shape Sliding Effect, Using Matched Geometry Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    init() {
        UITabBar.appearance().isHidden = true
    }
    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var sharedVM = SharedViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                SearchView(sharedVM: sharedVM)
                    .tag(Tab.search)
                    .tabItem { Text("Search") }
                    .onTapGesture {
                        activeTab = .search
                    }
                
                ProjectsView()
                    .tag(Tab.projects)
                
                MeView()
                    .tag(Tab.me)
                
                CollectionsView()
                    .tag(Tab.collections)
                
                MoreView()
                    .tag(Tab.more)
            }
            .onChange(of: activeTab) { newValue in
                if !userVM.isLoggedIn && newValue != .search {
                    // Prompt user to log in if they try to access a different tab
                    // You can show an alert or navigate to the login page here
                    // For example, you can present a sheet with the login view
                    promptLogin = true
                }
            }
            .sheet(isPresented: $promptLogin) {
                // Present the login view here
                LoginView()
            }
            
            CustomTabBar()
        }
    }

    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("PlungeBlack"), _ inactiveTint: Color = .gray) -> some View {
        /// Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                /// Adding Blur + Shadow
                /// For Shape Smoothening
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        /// Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    } 
}
