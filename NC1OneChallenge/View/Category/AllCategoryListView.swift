//
//  AllCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct AllCategoryListView: View {
    @Binding var categoryVM: CategoryVM
    @State var categories = [Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")]
    
    var user: User
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                NavigationLink(destination: {
                    AllCategoryDetailView(category: category, categoryVM: $categoryVM, user: user)
                }, label: {
                    Text(category.categoryName)
                })
            }
            .listStyle(.plain)
            .task {
                categoryVM.fetchAll({ data in
                    if !(data.isEmpty) {
                        self.categories = data
                    }
                })
            }
        }
    }
}
