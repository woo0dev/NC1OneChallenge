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
    
    var body: some View {
        MainView(isSignIn: $isSignIn)
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
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window, isSignIn: $isSignIn)
        appleLoginCoordinator?.startAppleLogin()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .font(.custom("BMJUAOTF", size: 30))
            .foregroundColor(Color.white)
            .background(Color("MainColor"))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}
