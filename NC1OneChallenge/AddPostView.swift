//
//  AddPostView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/29.
//

import SwiftUI

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var categoryName: String
    @Binding var posts: [post]
    @State var title: String = ""
    @State var description: String = ""
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                VStack {
                    Text("\(categoryName)")
                        .font(.custom("BMJUAOTF", size: 40))
                        .foregroundColor(Color("MainColor"))
                        .padding(10)
                }
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(.custom("BMJUAOTF", size: 30))
                    TextField("", text: $title)
                        .frame(width: geometry.size.width-39, height: 40)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"), lineWidth: 1)
                        )
                        .font(.custom("BMJUAOTF", size: 20))
                        .onAppear(perform: UIApplication.shared.hideKeyboard)
                    Text("설명")
                        .font(.custom("BMJUAOTf", size: 30))
                    TextEditor(text: $description)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainColor"), lineWidth: 1)
                        )
                        .font(.custom("BMJUAOTF", size: 20))
                        .onAppear(perform: UIApplication.shared.hideKeyboard)
                    Button(action: {
                        posts.append(post(categoryName: categoryName, title: title, description: description))
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("등록하기")
                    }
                    .buttonStyle(customButtonStyle())
                }
                .padding(20)
            }
        }
    }
}
