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
                HStack {
                    Text("\(categoryName)")
                        .font(.custom("BMJUAOTF", size: 40))
                        .foregroundColor(Color("MainColor"))
                        .padding(10)
                    Spacer()
//                    Button(action: {
//                    }) {
//                        NavigationLink(destination: AddPostView(categoryName: categoryName, posts: $posts)) {
//                            Text("글 작성하기")
//                        }
//                    }
//                    .frame(width: 100, height: 40)
//                    .font(.custom("BMJUAOTF", size: 20))
//                    .foregroundColor(Color.white)
//                    .background(Color("MainColor"))
//                    .cornerRadius(10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color("MainColor"), lineWidth: 1)
//                    )
                }
                .padding([.trailing], 10)
                ScrollView {
                    ForEach(posts, id: \.self) { post in
                        NavigationLink( destination: PostDetailView(posts: $posts, categoryName: post.categoryName, title: post.title, description: post.description, postImage: post.image, date: post.date)) {
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
                }
                Spacer()
            }
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddPostView(categoryName: categoryName, posts: $posts)) {
                Image(systemName: "plus.circle")
                    .foregroundColor(Color("BlackColor"))
            }
            )
        }
    }
}

