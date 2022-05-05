//
//  ContentView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import AuthenticationServices

struct ContentView: View {
    @Environment(\.calendar) var calendar
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }
    @State var categorys: [category] = [category(categoryName: "1일 1커밋", categoryDescription: "1일 1커밋을 꾸준히 합시다!", categoryImage: UIImage(systemName: "plus.circle")!)]
    @State var posts: [post] = []
    @State var dates: [String] = []
    @State private var showModal = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView() {
                    HStack {
                        Text("다양한 습관들을 살펴보세요!")
                            .font(.custom("BMJUAOTF", size: 27))
                            .padding([.leading], 5)
                            .padding([.trailing], 55)
                            .padding([.top], 20)
                            .navigationBarTitle("One Challenge", displayMode: .inline)
                    }
                    VStack {
                        NavigationLink(destination: AddCategoryView(categorys: $categorys)) {
                            VStack {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.gray)
                                    .padding([.bottom], 10)
                                Text("습관을 등록해보세요!")
                                    .bold()
                                    .foregroundColor(Color("BlackColor"))
                            }
                        }
                    }
                    .frame(width: geometry.size.width-20, height: 150)
                    .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainColor"), lineWidth: 1)
                            )
                            .padding([.top, .horizontal])
                    VStack {
                        ForEach(categorys, id: \.self) { category in
                            NavigationLink( destination: CategoryDetailView(categoryName: category.categoryName, posts: $posts)) {
                                CardView(categoryName: category.categoryName, categoryDescription: category.categoryDescription, categoryImage: category.categoryImage)
                            }
                        }
                    }
                }
                .navigationBarTitle("One Challenge", displayMode: .inline)
                .navigationBarItems(leading:
                                        Button(action: {
                                            dates = posts.map {
                                                return $0.date
                                            }
                                            print(dates)
                                            self.showModal = true
                                        }, label: {
                                            Image(systemName: "calendar")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .padding([.top], 20)
                                                .padding([.trailing], 10)
                                                .foregroundColor(Color("BlackColor"))
                                        })
                                        .sheet(isPresented: self.$showModal) {
                                            CalendarView(interval: self.year) { date in
                                                Text("30")
                                                    .hidden()
                                                    .padding(8)
                                                    .background(Color("\(calendarColor(dates, date: date))"))
                                                    .clipShape(Rectangle())
                                                    .cornerRadius(4)
                                                    .padding(4)
                                                    .overlay(
                                                        Text(String(self.calendar.component(.day, from: date)))
                                                            .foregroundColor(Color.black)
                                                    )
                                            }
                                        },
                                    trailing:
                                        NavigationLink(
                                            destination: ProfileView(),
                                            label: {
                                                Image(systemName: "person.fill")
                                                    .foregroundColor(Color("BlackColor"))
                                            }
                                        )
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .font(.custom("BMJUAOTF", size: 30))
            .foregroundColor(Color.white)
            .background(Color("MainColor"))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}
