//
//  CategoryDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct CategoryDetailView: View {
    @State var categoryName: String
    @Binding var posts: [post]
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(categoryName)")
                .font(.custom("BMJUAOTF", size: 40))
                .foregroundColor(Color("MainColor"))
            ForEach(posts, id: \.self) { post in
                NavigationLink( destination: PostDetailView()) {
                    post.categoryName == categoryName ? Text("\(post.title)").font(.custom("BMJUAOTF", size: 25)).foregroundColor(Color("BlackColor")) : Text("")
                }
            }
            Spacer()
        }
    }
}

