//
//  CardView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct CardView: View {
    @State var categoryName: String
    @State var categoryDescription: String
    @State var categoryImage: Image
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack {
                    Text("\(categoryName)")
                    .foregroundColor(Color("MainColor"))
                    .font(.custom("BMJUAOTF", size: 27))
                }
                VStack {
                    categoryImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 125)
                        .padding(.horizontal, 35)
                }
                VStack {
                    Text("\(categoryDescription)")
                        .foregroundColor(Color("BlackColor"))
                        .font(.custom("BMJUAOTF", size: 16))
                }
                HStack {
                    Spacer()
                }
            }
            .padding()
        }
        .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainColor"), lineWidth: 1)
                )
                .padding([.top, .horizontal])
    }
}

