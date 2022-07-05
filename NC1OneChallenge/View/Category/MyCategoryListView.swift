//
//  MyCategoryListView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct MyCategoryListView: View {
    @Binding var categoryVM: CategoryVM
    
    var user: User
    
    var body: some View {
        VStack {
            List(categoryVM.myCategories, id: \.self) { category in
                NavigationLink(destination: {
                    MyCategoryDetailView(category: category, categoryVM: $categoryVM, user: user)
                }, label: {
                    Text(category.categoryName)
                })
            }
            .listStyle(.plain)
        }
    }
}
