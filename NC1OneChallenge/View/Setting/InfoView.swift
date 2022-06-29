//
//  InfoView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

import AuthenticationServices
import Firebase

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isSignIn: Bool
    
    @State var infoVM = InfoVM()
    @State var count = 0
    
    var user: User
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(user.name)
                Text("\(count)")
                Button(action: {
                    isSignIn = true
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("로그아웃")
                })
            }
            Spacer()
            Spacer()
        }
        .task {
            try? await self.infoVM.fetchRecordCount(userUid: user.uid)
            count = infoVM.recordCount
        }
    }
}
