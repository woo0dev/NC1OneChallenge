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
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("\(categoryName)")
                    .font(.custom("BMJUAOTF", size: 40))
                    .foregroundColor(Color("MainColor"))
                    .padding(10)
                ForEach(posts, id: \.self) { post in
                    NavigationLink( destination: PostDetailView(title: post.title, description: post.description)) {
                        if post.categoryName == categoryName {
                            Text("\(post.title)")
                                .font(.custom("BMJUAOTF", size: 25))
                                .foregroundColor(Color("BlackColor"))
                                .frame(width: geometry.size.width-20, height: 50)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("MainColor"), lineWidth: 1)
                                )
                                .padding(10)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

