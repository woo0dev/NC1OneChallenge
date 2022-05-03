//
//  ProfileView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/05/04.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import AuthenticationServices

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.window) var window: UIWindow?
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    @Binding var isPresented: Bool
    var body: some View {
        if Auth.auth().currentUser != nil {
            Text("@")
            Button(action: {
                try! Auth.auth().signOut()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("로그아웃")
            })
        } else {
            QuickSignInWithApple()
                    .frame(width: 280, height: 60, alignment: .center)
                    .onTapGesture {
                        appleLogin()
                        self.presentationMode.wrappedValue.dismiss()
                    }
        }
    }
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window)
        appleLoginCoordinator?.startAppleLogin()
    }
}
