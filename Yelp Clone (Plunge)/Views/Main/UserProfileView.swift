//
//  UserProfileView.swift
//  Unibui_App
//
//  Created by Dillon Kermani on 7/8/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        if userVM.isLoggedIn {
            NavigationView {
                GeometryReader {
                    let size = $0.size
                    let safeArea = $0.safeAreaInsets
                    VStack {
                        SplitView(size: size, safeArea: safeArea, userVM: userVM, info: {
                            UserInfoView()
                        })
                        .ignoresSafeArea(.all, edges: .top)
                    }
                }
            }.onAppear {
                userVM.refreshUser()
            }
        }
    }
    
    func UserInfoView() -> some View {
        VStack {
            if userVM.isLoggedIn {
                
                Group {
                    HStack {
                        Text("Hello \(userVM.user.firstName)")
                            .font(.custom("Futura-Bold", size: 27))
                        Spacer()
                    }.padding(.top, 25)
                    
                    
                    HStack {
                        Text("\(userVM.user.email.lowercased())")
                            .font(.custom("Futura", size: 18))
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 30)
                    
                    HStack {
                        Text("Images Bookmarked: \(userVM.user.savedPhotos?.count ?? 0)")
                            .font(.custom("Futura", size: 22))
                        
                        Spacer()
                    }
                }.padding(.leading, 25)
                
                Spacer().frame(height: SCREEN_HEIGHT/4)
                
                SignOutButton()
                    .padding(25)
                
                Spacer().frame(height: SCREEN_HEIGHT/4)
                
                
            }

        }
            .foregroundColor(Color("PlungeBlack"))
    }
    
    func SignOutButton() -> some View {
        VStack {
            Button {
                userVM.logout()
            } label: {
                HStack {
                    Text("Sign Out")
                        .fontWeight(.semibold)
                }.foregroundColor(.white)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background {
                        Capsule()
                            .fill(.black)
                    }
            }

        }
    }
}

struct SplitViewControls {
    var cameraImagePicker = false
    var photoImagePicker = false
}

struct SplitView<Info: View>: View {
    var size: CGSize
    var safeArea: EdgeInsets
    /// View Properties
    @State private var offsetY: CGFloat = 0
    
    @State var controls = SplitViewControls()
    
    @StateObject var userVM: UserViewModel
    
    @State var profileImageData: Data = Data()
    @State var image: Image = Image("user-placeholder")
    
    var info: () -> Info
    

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                    /// Making to Top
                        .zIndex(1000)
                    
                    info()
                }
                .id("SCROLLVIEW")
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
                    } onDraggingEnd: { offset, velocity in
                        /// Resetting to Intial State, if not Completely Scrolled
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        
                        let targetEnd = offset + (velocity * 45)
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0 {
                            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        /// Converting Offset into Progress
        /// Limiting it to 0 - 1
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    
                
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingsView(), label: {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 34))
                            }

                        })
                    }.offset(x: 10, y: 40)
                        .moveText(1, headerHeight + 15, minimumHeaderHeight - 30)
                    /// Profile Image
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        /// Since Scaling of the Image is 0.3 (1 - 0.7)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
                        
                        
                        VStack(spacing: 0) {
                            Image("appicon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: rect.width, height: rect.height)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.white.opacity(0.3), radius: 8, y: 6)
                            /// Scaling Image
                                .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            /// Moving Scaled Image to Center Leading
                                .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                        }
                    }
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                    
                    Text("Profile")
                        .font(.custom("Futura-Bold", size: 22))
                        .foregroundColor(.white)
                        /// Advanced Method (Same as the Profile Image)
                        .moveText(progress, headerHeight, minimumHeaderHeight)
                    
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
            }
            /// Resizing Header
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            /// Sticking to the Top
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

