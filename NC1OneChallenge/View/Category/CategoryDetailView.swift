//
//  CategoryDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct CategoryDetailView: View {
    @State var category: Category
    
    var categoryVM: CategoryVM
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("제목: \(category.categoryName)")
                .font(.title)
                .padding(.bottom, 5)
            Text("소개: \(category.categoryDescription)")
                .padding(.bottom, 5)
            Text("참여자: \(category.participants.count)명")
                .padding(.bottom, 5)
            Spacer()
            HStack(alignment: .center) {
                if category.participants.contains(getUserInfo().uid) {
                    Button(action: {
                        categoryVM.deleteCategory(category: category)
                    }, label: {
                        
                    })
                } else {
                    Button(action: {
                        
                    }, label: {
                        
                    })
                }
            }
        }
    }
}

