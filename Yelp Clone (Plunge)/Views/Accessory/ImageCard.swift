//
//  ImageCard.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/10/23.
//

import SwiftUI

struct ImageCard: View {
    var url: String
    @State private var isOverlayVisible = false
    
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
                Color.gray.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: 150, height: 250)
                    .cornerRadius(15)
                    .onTapGesture {
                        isOverlayVisible.toggle()
                    }
                
                // Share Button
                VStack {
                    Spacer()
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
                }
            }
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
}
