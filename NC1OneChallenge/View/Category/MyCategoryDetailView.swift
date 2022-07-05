//
//  MyCategoryDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

struct MyCategoryDetailView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var dates: [String] = []
    @State var records = [Record(recordUid: "", userUid: "", userName: "", categoryName: "", date: "")]
    @State private var showModal = false
    
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }
    
    var category: Category
    @Binding var categoryVM: CategoryVM
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
                Text("총 횟수: \(record.myRecord.count)")
                ScrollView() {
                    ForEach(record.myRecord, id: \.self) { record in
                        Text(record.date)
                    }
                }
            }
            .frame(maxWidth: .infinity-30, alignment: .leading)
            .padding(.leading, 15)
            .padding(.bottom, 30)
            Spacer()
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Button(action: {
                        record.addRecord(record: Record(userUid: user.uid, userName: user.name, categoryName: category.categoryName, date: dateToStringFormat(Date())))
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
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    dates = record.myRecord.map {
                        return dateWithTimeRemoved(stringToDateFormat($0.date))
                    }
                    self.showModal = true
                }, label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color("BlackColor"))
                })
                .sheet(isPresented: self.$showModal) {
                    CalendarView(interval: self.year) { date in
                        Text("30")
                            .hidden()
                            .padding(8)
                            .background(Color("\(calendarColor(dates, date: dateWithTimeRemoved(date)))"))
                            .clipShape(Rectangle())
                            .cornerRadius(4)
                            .padding(4)
                            .overlay(
                                Text(String(self.calendar.component(.day, from: date)))
                                    .foregroundColor(Color.black)
                            )
                    }
                }
            })
        }
        .task {
            try? await self.record.fetchMyRecord(categoryName: category.categoryName, userUid: user.uid)
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
