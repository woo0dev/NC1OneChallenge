//
//  CardView.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/04/28.
//

import SwiftUI

struct CardView: View {
    @State var category: category
    var body: some View {
        //GeometryReader { geometry in
        VStack {
            ZStack {
                category.categoryImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 370, height: 200)
                    .padding(.horizontal, 35)
                    .scaledToFit()
                Text("\(category.categoryName)")
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(Color.white)
                    .font(.custom("BMJUAOTF", size: 27))
                    .offset(x: -23, y: 45)
                    .lineLimit(1)
                Text("\(category.categoryDescription)")
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(Color.white)
                    .font(.custom("BMJUAOTF", size: 16))
                    .offset(x: -23, y: 75)
                    .lineLimit(1)
            }
            
        //}
        }
        .frame(width: 370, height: 200)
        .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("MainColor"), lineWidth: 1)
                )
                .padding([.top, .horizontal])
    }
}

