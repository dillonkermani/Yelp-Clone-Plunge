//
//  ImageCard.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/10/23.
//

import SwiftUI

struct ImageCard: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var url: String
    @State private var isOverlayVisible = false
    @State private var imageBookmarked = false
    @State private var promptLogin = false
    
    var body: some View {
        ZStack {
            Button {
                isOverlayVisible.toggle()
            } label: {
                // Image
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        Color.red // Placeholder color for error case
                    case .empty:
                        ProgressView()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 150, height: 250)
                .cornerRadius(15)
            }

            // Transparent Overlay
            if isOverlayVisible {
                Group {
                    VStack(spacing: 0) {
                        Color.purple.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: 150, height: 125)
                            .cornerRadius(15, corners: [.topLeft, .topRight])
                            .onTapGesture {
                                isOverlayVisible.toggle()
                            }
                        
                        Color.blue.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: 150, height: 125)
                            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                            .onTapGesture {
                                isOverlayVisible.toggle()
                            }
                    }
                    
                    
                    
                    // Share Button
                    VStack(spacing: 15) {
                        Button(action: {
                            shareURL()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if !userVM.isLoggedIn {
                                self.promptLogin.toggle()
                            } else {
                                if userVM.user.savedPhotos == nil {
                                    bookmarkImage()
                                }
                                else if (userVM.user.savedPhotos!.contains(url)) {
                                    removeBookmark()
                                } else {
                                    bookmarkImage()
                                }
                            }
                        }) {
                            if userVM.user.savedPhotos == nil {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            } else if (userVM.user.savedPhotos!.contains(url)) {
                                Image(systemName: "bookmark.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                        
                    }
                    .padding(.vertical, 30)
                    
                    
                }.frame(width: 150, height: 250)
            }
        }
        .sheet(isPresented: $promptLogin) {
            // Present the login view here
            LoginView()
        }
    }
    
    private func shareURL() {
        guard let shareURL = URL(string: url) else {
            return
        }
        let avController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            let windows = windowScene.windows
            if let rootViewController = windows.first?.rootViewController {
                rootViewController.present(avController, animated: true, completion: nil)
            }
        }
    }
    
    private func bookmarkImage() {
        withAnimation {
            self.imageBookmarked = true
        }
        userVM.addBookmark(url: url)
        userVM.refreshUser()
        
    }
    
    private func removeBookmark() {
        withAnimation {
            self.imageBookmarked = false
        }
        userVM.removeBookmark(url: url)
        userVM.refreshUser()
    }
}
