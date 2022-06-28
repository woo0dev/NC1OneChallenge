//
//  ContentView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

import Firebase
import AuthenticationServices

struct ContentView: View {
    @Environment(\.window) var window: UIWindow?
    
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    @State var isSignIn: Bool = Auth.auth().currentUser == nil ? true : false
    
    @State var user = User(uid: "", name: "")
    
    var categoryVM = CategoryVM()

    init() {
        categoryVM.fetchAllCategories()
        categoryVM.fetchMyCategories(uid: user.uid)
    }
    
    var body: some View {
        MainView(isSignIn: $isSignIn, user: $user, categoryVM: categoryVM)
            .fullScreenCover(isPresented: $isSignIn, content: {
                QuickSignInWithApple()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56, alignment: .center)
                    .onTapGesture {
                        appleLogin()
                    }
                    .padding(.bottom, 60)
                    .padding(.horizontal, 17)
            })
            .task {
                try? await user = getUserInfo()
            }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window, isSignIn: $isSignIn)
        appleLoginCoordinator?.startAppleLogin()
    }
}
