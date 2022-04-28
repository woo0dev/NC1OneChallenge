//
//  AddCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct AddCategoryView: View {
    @Binding var categorys: [category]
    @State var categoryName: String = ""
    @State var categoryDescription: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("습관 이름")
                .font(.custom("BMJUAOTF", size: 30))
            TextField("", text: $categoryName)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainColor"), lineWidth: 1)
                )
                .font(.custom("BMJUAOTF", size: 30))
                .onAppear(perform: UIApplication.shared.hideKeyboard)
            Text("설명")
                .font(.custom("BMJUAOTf", size: 30))
            TextEditor(text: $categoryDescription)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainColor"), lineWidth: 1)
                )
                .font(.custom("BMJUAOTF", size: 30))
                .onAppear(perform: UIApplication.shared.hideKeyboard)
            Button(action: {
                categorys.append(category(categoryName: categoryName, categoryDescription: categoryDescription, categoryImage: ""))
            }) {
                Text("등록하기")
            }
            .buttonStyle(customButtonStyle())
        }
        .padding(20)
    }
}

