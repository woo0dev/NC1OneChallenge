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
    
    @ObservedObject var category: CategoryVM
    @State private var selectedSide: CategoryPicker = .all
    
    init(isSignIn: Binding<Bool>, category: CategoryVM) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("MainColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self._isSignIn = isSignIn
        self.category = category
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
                
                ChosenCategoryView(categories: selectedSide == .all ? category.allCategories : category.myCategories, selectedSide: selectedSide)
                
                Spacer()
                
            }
            .task {
                self.category.fetchAllCategories()
                self.category.fetchMyCategories(uid: getUserInfo().uid)
            }
        }
    }
}

struct ChosenCategoryView: View {
    var categories: [Category]
    var selectedSide: CategoryPicker
    
    var body: some View {
        switch selectedSide {
        case .all:
            AllCategoryListView(categories: categories)
        case .my:
            MyCategoryListView(categories: categories)
        }
    }
}