//
//  AllCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct AllCategoryListView: View {
    @State var category: CategoryVM
    @State var categories = [Category(categoryUid: "", adminName: "", participants: [""], categoryName: "", categoryDescription: "")]
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                Text("\(category.categoryName)")
            }
            .task {
                category.fetchAll({ data in
                    if !(data.isEmpty) {
                        self.categories = data
                    }
                })
            }
        }
    }
}
