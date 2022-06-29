//
//  AddCategoryView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var title = ""
    @State var description = ""
    
    var categoryVM: CategoryVM
    var user: User
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("습관 추가하기")
                    .font(.title)
                    .padding(.bottom, 10)
                Text("이름")
                TextField("", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 15)
                Text("설명")
                TextField("", text: $description)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 15)
            }
            .frame(maxWidth: .infinity-30, alignment: .leading)
            .padding(.leading, 15)
            Spacer()
            VStack(alignment: .center) {
                Button("만들기") {
                    categoryVM.addCategory(category: Category(adminName: user.name, participants: [user.uid], categoryName: title, categoryDescription: description))
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(MyButtonStyle())
            }
        }
    }
}

