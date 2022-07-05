//
//  InfoView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/27.
//

import SwiftUI

import AuthenticationServices
import Firebase

struct InfoView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isSignIn: Bool
    
    @State var count = 0
    @State var dates: [String] = []
    @State var infoVM = InfoVM()
    @State private var showModal = false
    @State var user: User
    
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("\(user.name)님")
                        .font(.title2)
                    Text("총 실천 횟수: \(count)")
                }
                VStack {
                    ScrollView() {
                        ForEach(infoVM.recordDates, id: \.self) { date in
                            Text(date)
                        }
                    }
                }
                Button("로그아웃") {
                    isSignIn = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(MyButtonStyle())
            }
            Spacer()
        }
        .navigationBarTitle(Text("내 정보"), displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    dates = infoVM.recordDates.map {
                        return dateWithTimeRemoved(stringToDateFormat($0))
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
            try? await self.infoVM.fetchRecordCount(userUid: user.uid)
            try? await self.infoVM.fetchMyAllRecord(userUid: user.uid)
            count = infoVM.recordCount
        }
    }
}
