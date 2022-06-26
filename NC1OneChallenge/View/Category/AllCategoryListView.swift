//
//  AllCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct AllCategoryListView: View {
    @State var categories: [Category]
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                Text("\(category.categoryName)")
            }
        }
    }
}
