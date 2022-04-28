//
//  PostDetailView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/29.
//

import SwiftUI

struct PostDetailView: View {
    @State var title: String
    @State var description: String
    var body: some View {
        Text(title)
        Text(description)
    }
}
