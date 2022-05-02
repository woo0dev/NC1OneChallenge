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
        GeometryReader { geometry in
            ZStack {
                categoryImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 125)
                    .padding(.horizontal, 35)
                    .scaledToFit()
                Text("\(categoryName)")
                    .foregroundColor(Color("MainColor"))
                    .font(.custom("BMJUAOTF", size: 27))
                    .offset(x: -125, y: 45)
                Text("\(categoryDescription)")
                    .foregroundColor(Color("BlackColor"))
                    .font(.custom("BMJUAOTF", size: 16))
                    .offset(x: -90, y: 75)
    //            VStack(alignment: .leading) {
    //                VStack {
    //                    categoryImage
    //                        .resizable()
    //                        .aspectRatio(contentMode: .fit)
    //                        .frame(width: 250, height: 125)
    //                        .padding(.horizontal, 35)
    //                        .scaledToFit()
    //                }
    //                VStack {
    //                    Text("\(categoryName)")
    //                    .foregroundColor(Color("MainColor"))
    //                    .font(.custom("BMJUAOTF", size: 27))
    //                }
    //                VStack {
    //                    Text("\(categoryDescription)")
    //                        .foregroundColor(Color("BlackColor"))
    //                        .font(.custom("BMJUAOTF", size: 16))
    //                }
    //                HStack {
    //                    Spacer()
    //                }
    //            }
    //            .padding()
            }
            .frame(width: geometry.size.width-32, height: 200)
            .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainColor"), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
        }
    }
}

