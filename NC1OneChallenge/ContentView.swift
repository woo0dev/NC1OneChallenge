//
//  ContentView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    @State var categorys: [category] = [category(categoryName: "1일 1커밋", categoryDescription: "1일 1커밋을 꾸준히 합시다!", categoryImage: "git"), category(categoryName: "@!#!@#", categoryDescription: "!@#!@#!@#!@#!@##@!", categoryImage: "git")]
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView() {
                    VStack {
                        Text("다양한 습관들을 살펴보세요!")
                            .font(.custom("BMJUAOTF", size: 27))
                            .padding([.leading], 20)
                            .padding([.trailing], 55)
                            .padding([.top], 20)
                            .navigationBarTitle("One Challenge", displayMode: .inline)
                        Button(action: {
                        }) {
                            NavigationLink(destination: AddCategoryView()) {
                                Text("습관 등록하기")
                            }
                        }
                        .buttonStyle(customButtonStyle())
                    }
                    ForEach(categorys, id: \.self) { category in
                        NavigationLink( destination: CategoryDetailView(categoryName: category.categoryName)) {
                            CardView(categoryName: category.categoryName, categoryDescription: category.categoryDescription, categoryImage: category.categoryImage)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .font(.custom("BMJUAOTF", size: 30))
            .foregroundColor(Color.white)
            .background(Color("MainColor"))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}
