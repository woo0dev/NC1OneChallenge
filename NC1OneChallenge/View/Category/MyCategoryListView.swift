//
//  MyCategoryListView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct MyCategoryListView: View {
    @State var categories: [Category]
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                NavigationLink(destination: {
                    CategoryDetailView()
                }, label: {
                    Text(category.categoryName)
                })
            }
            .listStyle(.plain)
        }
    }
}
