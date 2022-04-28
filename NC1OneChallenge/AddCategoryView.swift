//
//  AddCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct AddCategoryView: View {
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
            Text("설명")
                .font(.custom("BMJUAOTf", size: 30))
            TextEditor(text: $categoryDescription)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainColor"), lineWidth: 1)
                )
        }
        .padding(20)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
