//
//  PostDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/29.
//

import SwiftUI

struct PostDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var posts: [post]
    @State var title: String
    @State var description: String
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                VStack {
                    Text("\(title)")
                        .font(.custom("BMJUAOTF", size: 40))
                        .foregroundColor(Color("MainColor"))
                        .padding(10)
                }
                VStack {
                    Text("\(description)")
                        .frame(width: geometry.size.width-40, height: 300)
                        .border(Color("MainColor"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"), lineWidth: 1)
                        )
                        .padding(20)
                }
                VStack {
                    Button(action: {
//                        if let index = posts.firstIndex(of: post) {
//                            posts.remove(at: index)
//                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("삭제하기")
                    }
                    .buttonStyle(customButtonStyle())
                }
            }
        }
    }
}