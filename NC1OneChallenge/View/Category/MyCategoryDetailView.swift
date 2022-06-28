//
//  MyCategoryDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct MyCategoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var records = [Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")]
    
    var category: Category
    var categoryVM: CategoryVM
    var record = RecordVM()
    var user: User
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("\(category.categoryName)")
                    .font(.title)
                    .padding(.bottom, 5)
            }
            .frame(maxWidth: .infinity-30, alignment: .leading)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            VStack(alignment:.leading, spacing: 3) {
                Text("내 기록")
                    .font(.title2)
                Text("총 횟수: \(records.count)")
                ForEach(records, id: \.self) { record in
                    Text(record.date)
                }
            }
            .frame(maxWidth: .infinity-30, alignment: .leading)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            Spacer()
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Button(action: {
                        record.addRecord(record: Record(userUid: user.uid, userName: user.name, categoryName: category.categoryName, date: dateFormat(Date())))
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("추가")
                    })
                    .frame(width: 230, height: 45)
                    .font(.system(size: 14))
                    .foregroundColor(Color("BlackColor"))
                    .border(Color("MainColor"), width: 2)
                }
                Button(action: {
                    categoryVM.deleteParticipantCategory(category: category, userUid: user.uid)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("즐겨찾기 삭제")
                })
                .frame(width: 230, height: 45)
                .font(.system(size: 14))
                .foregroundColor(Color("BlackColor"))
                .border(Color("MainColor"), width: 2)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .task {
            record.fetchMyRecord(categoryName: category.categoryName, userUid: user.uid, { data in
                if !(data.isEmpty) {
                    self.records = data
                }
            })
        }
    }
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("<")
            .foregroundColor(Color("MainColor"))
    }
    }
}
