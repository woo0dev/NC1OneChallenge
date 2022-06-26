//
//  MainView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/26.
//

import SwiftUI

import Firebase
import AuthenticationServices

struct MainView: View {
    @Binding var isSignIn: Bool
    
    var body: some View {
        Button(action: {
            try! Auth.auth().signOut()
            isSignIn = true
        }, label: {
            Rectangle()
                .frame(width: 50, height: 50)
        })
    }
}
