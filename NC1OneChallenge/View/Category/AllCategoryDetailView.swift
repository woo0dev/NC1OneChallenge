//
//  CategoryDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct AllCategoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var category: Category
    
    @Binding var categoryVM: CategoryVM
    var user: User
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("제목: \(category.categoryName)")
                    .font(.title)
                    .padding(.bottom, 5)
                Text("소개: \(category.categoryDescription)")
                    .padding(.bottom, 5)
                Text("참여자: \(category.participants.count)명")
                    .padding(.bottom, 5)
            }
            .frame(maxWidth: .infinity-30, alignment: .leading)
            .padding(.leading, 15)
            Spacer()
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    if category.participants.contains(user.uid) {
                        Button(action: {
                            categoryVM.deleteParticipantCategory(category: category, userUid: user.uid)
                            Task {
                                do {
                                    try? await self.categoryVM.fetchMyCategories(uid: user.uid)
                                }
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("즐겨찾기 삭제")
                        })
                        .frame(width: 230, height: 45)
                        .font(.system(size: 14))
                        .foregroundColor(Color("BlackColor"))
                        .border(Color("MainColor"), width: 2)
                    } else {
                        Button(action: {
                            categoryVM.addParticipantCategory(category: category, userUid: user.uid)
                            Task {
                                do {
                                    try? await self.categoryVM.fetchMyCategories(uid: user.uid)
                                }
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("즐겨찾기 추가")
                        })
                        .frame(width: 230, height: 45)
                        .font(.system(size: 14))
                        .foregroundColor(Color("BlackColor"))
                        .border(Color("MainColor"), width: 1)
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("<")
            .foregroundColor(Color("MainColor"))
    }
    }
}

