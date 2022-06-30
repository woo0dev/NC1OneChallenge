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
    @Environment(\.window) var window: UIWindow?
    
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    @State var categoryVM = CategoryVM()
    @State var isSignIn: Bool = Auth.auth().currentUser == nil ? true : false
    @State private var selectedSide: CategoryPicker = .all
    @State var user = User(uid: "", name: "")

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("MainColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        if !isSignIn {
            categoryVM.fetchAllCategories()
            categoryVM.fetchMyCategories(uid: user.uid)
        }
    }
    
    var body: some View {
        if isSignIn {
            VStack {
                Spacer()
                Text("1")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 100))
                Text("OneChallenge")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 36))
                Spacer()
                QuickSignInWithApple()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56, alignment: .center)
                    .onTapGesture {
                        appleLogin()
                    }
                    .padding(.bottom, 60)
                    .padding(.horizontal, 17)
                    .task {
                        if Auth.auth().currentUser != nil {
                            try! Auth.auth().signOut()
                        }
                    }
            }
            .background(Color("MainColor"))
        } else {
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: {
                            InfoView(isSignIn: $isSignIn, user: user)
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
            .task {
                if !isSignIn {
                    try? await user = getUserInfo()
                    self.categoryVM.fetchAllCategories()
                    self.categoryVM.fetchMyCategories(uid: user.uid)
                }
            }
        }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window, isSignIn: $isSignIn)
        appleLoginCoordinator?.startAppleLogin()
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
