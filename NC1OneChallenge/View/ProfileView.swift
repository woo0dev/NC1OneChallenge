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
        if isPresented {
            Text("@")
        } else {
            QuickSignInWithApple()
                    .frame(width: 280, height: 60, alignment: .center)
                    .onTapGesture {
                        appleLogin()
                    }
        }
    }
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window)
        appleLoginCoordinator?.startAppleLogin()
    }
}
