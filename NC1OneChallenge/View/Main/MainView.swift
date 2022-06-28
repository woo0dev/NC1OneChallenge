//
//  MainView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/26.
//

import SwiftUI

import Firebase
import AuthenticationServices

struct MainView: View {
    @Binding var isSignIn: Bool
    
    @State private var selectedSide: CategoryPicker = .all
    
    var categoryVM: CategoryVM
    var user: User
    
    init(isSignIn: Binding<Bool>, categoryVM: CategoryVM, user: User) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("MainColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self._isSignIn = isSignIn
        self.categoryVM = categoryVM
        self.user = user
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("ads", selection: $selectedSide) {
                    ForEach(CategoryPicker.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ChosenCategoryView(categoryVM: categoryVM, categories: selectedSide == .all ? categoryVM.allCategories : categoryVM.myCategories, selectedSide: selectedSide, user: user)
                
                Spacer()
                
            }
            .task {
                self.categoryVM.fetchAllCategories()
                self.categoryVM.fetchMyCategories(uid: user.uid)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: {
                        InfoView()
                    }, label: {
                        Image(systemName: "person")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        AddCategoryView(categoryVM: categoryVM, user: user)
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct ChosenCategoryView: View {
    var categoryVM: CategoryVM
    var categories: [Category]
    var selectedSide: CategoryPicker
    var user: User
    
    var body: some View {
        switch selectedSide {
        case .all:
            AllCategoryListView(categoryVM: categoryVM, categories: categories, user: user)
        case .my:
            MyCategoryListView(categoryVM: categoryVM, categories: categories, user: user)
        }
    }
}
