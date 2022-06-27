//
//  MyCategoryListView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct MyCategoryListView: View {
    @State var categoryVM: CategoryVM
    @State var categories: [Category]
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                NavigationLink(destination: {
                    MyCategoryDetailView(category: category, categoryVM: categoryVM)
                }, label: {
                    Text(category.categoryName)
                })
            }
            .listStyle(.plain)
        }
    }
}
