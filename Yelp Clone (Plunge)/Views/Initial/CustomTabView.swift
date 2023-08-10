//
//  TabView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/9/23.
//

import SwiftUI

struct CustomTabView: View {

    @State private var activeTab: Tab = .search
    /// For Smooth Shape Sliding Effect, Using Matched Geometry Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {

                SearchView()
                    .tag(Tab.search)
                
                ProjectsView()
                    .tag(Tab.projects)
                
                MeView()
                    .tag(Tab.me)
                
                CollectionsView()
                    .tag(Tab.collections)
                
                MoreView()
                    .tag(Tab.more)
                
            }
            
            CustomTabBar()
        }
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("YelpRed"), _ inactiveTint: Color = .gray) -> some View {
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
