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
    
    var category = CategoryVM()

    init() {
        category.fetchAllCategories()
        category.fetchMyCategories(uid: getUserInfo().uid)
        print("첫화면")
        print("\(category.allCategories)")
    }
    
    var body: some View {
        MainView(isSignIn: $isSignIn, category: category)
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
            .environmentObject(category)
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window, isSignIn: $isSignIn)
        appleLoginCoordinator?.startAppleLogin()
    }
}
