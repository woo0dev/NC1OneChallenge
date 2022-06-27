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
    
    init(isSignIn: Binding<Bool>, categoryVM: CategoryVM) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("MainColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self._isSignIn = isSignIn
        self.categoryVM = categoryVM
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
                
                ChosenCategoryView(categoryVM: categoryVM, categories: selectedSide == .all ? categoryVM.allCategories : categoryVM.myCategories, selectedSide: selectedSide)
                
                Spacer()
                
            }
            .task {
                self.categoryVM.fetchAllCategories()
                self.categoryVM.fetchMyCategories(uid: getUserInfo().uid)
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
                        AddCategoryView()
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
    
    var body: some View {
        switch selectedSide {
        case .all:
            AllCategoryListView(categoryVM: categoryVM, categories: categories)
        case .my:
            MyCategoryListView(categoryVM: categoryVM, categories: categories)
        }
    }
}
