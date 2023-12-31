//
//  LoginView.swift
//  Yelp Clone (Plunge)
//
//  Created by Dillon Kermani on 8/11/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var loginVM = LoginViewModel()
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var showSignIn: Bool = false
    @State private var errorMessage: String = ""
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size) {
                VStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("Change")
                            .font(.system(size: 40))
                            .fontWeight(.black)
                        Text("Your Life.")
                            .font(.system(size: 40))
                            .fontWeight(.black)
                        Spacer()
                    }
                    .offset(y: -30)
                    
                    ScrollView {
                        VStack {
                            if !self.showSignIn {
                                HStack {
                                    CustomTextField(text: $loginVM.firstName, hint: "First Name", leadingIcon: Image(systemName: "person"))
                                    CustomTextField(text: $loginVM.lastName, hint: "Last Name", leadingIcon: Image(systemName: "person"))
                                }
                            }
                            CustomTextField(text: $loginVM.email, hint: "Email Address", leadingIcon: Image(systemName: "envelope"))
                            CustomTextField(text: $loginVM.password, hint: "Password", leadingIcon: Image(systemName: "lock"), isPassword: true)
                        }
                    }
                    .frame(height: 175)
                    
                    if !self.showSignIn {
                        SignUpButton()
                    } else {
                        SignInButton()
                    }
                    
                    Button {
                        self.showSignIn.toggle()
                    } label: {
                        if showSignIn {
                            Text("Create a new account.")
                                .foregroundColor(.black)
                        } else {
                            Text("Already have an account?")
                                .foregroundColor(.black)
                        }
                    }

                    Text(errorMessage)
                        .foregroundColor(.red)
                        .lineLimit(2)
                        .font(.system(size: 12))
                }
                .padding(.top, 25)
            }
        }
        .padding(15)
        /// Manual Keyboard Push
        .offset(y: -keyboardHeight)
        /// Disabling Native Keyboard Push
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { output in
            if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                keyboardHeight = height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardHeight = 0
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
    }
    
    func SignInButton() -> some View {
        VStack {
            Button {
                loginVM.signin { user in
                    print("\(user) signed up successfully")
                    presentationMode.wrappedValue.dismiss()
                } onError: { errorMessage in
                    self.errorMessage = errorMessage
                    loginVM.isLoadingLogin = false
                    
                }

            } label: {
                HStack {
                    if loginVM.isLoadingLogin {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .fontWeight(.semibold)
                            
                    }
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
    
    func SignUpButton() -> some View {
        VStack {
            Button {
                loginVM.signup { user in
                    print("\(user) signed up successfully")
                    presentationMode.wrappedValue.dismiss()
                } onError: { errorMessage in
                    self.errorMessage = errorMessage
                    loginVM.isLoadingLogin = false
                    
                }

            } label: {
                HStack {
                    if loginVM.isLoadingLogin {
                        ProgressView()
                    } else {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            
                    }
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

/// Intro View
struct IntroView<ActionView: View>: View {
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
    /// Animation Properties
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    var body: some View {
        VStack {
            /// Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                    .frame(width: size.width, height: size.height)
            }
            /// Moving Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            /// Tile & Action's
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                
                if !intro.displaysAction {
                    Text(intro.title)
                        .font(.system(size: 40))
                        .fontWeight(.black)
                
                
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)

                    Group {
                        Spacer(minLength: 25)
                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    /// Action View
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Moving Down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        /// Back Button
        .overlay(alignment: .topLeading) {
            /// Hiding it for Very First Page, Since there is no previous page present
            if intro != pageIntros.first {
                Button {
                    changeIntro(true)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }
                .padding(0)
                /// Animating Back Button
                /// Comes From Top When Active
                .offset(y: showView ? 0 : -200)
                /// Hides by Going back to Top When In Active
                .offset(y: hideWholeView ? -200 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
    
    /// Updating Page Intro's
    func changeIntro(_ isPrevious: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            /// Updating Page
            if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            /// Re-Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}
