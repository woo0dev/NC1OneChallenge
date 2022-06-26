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
    
    @State var categoriesName = ["sad","SAD"]
    @State private var selectedSide: CategoryPicker = .all
    
    var category = CategoryVM()
    
    init(isSignIn: Binding<Bool>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("MainColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self._isSignIn = isSignIn
        category.fetchAllCategories()
        category.fetchMyCategories(uid: Auth.auth().currentUser?.uid != nil ? Auth.auth().currentUser!.uid : "")
    }
    
    var body: some View {
        NavigationView {
            HStack {
                Picker("ads", selection: $selectedSide) {
                    ForEach(CategoryPicker.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
            }
        }
    }
}
