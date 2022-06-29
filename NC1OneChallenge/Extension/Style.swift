//
//  Style.swift
//  NC1OneChallenge
//
//  Created by woo0 on 2022/06/30.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 10
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18))
            .padding()
            .foregroundColor(Color("WhiteColor"))
            .background(RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color("MainColor"))
                .frame(width: 230, height: 50))
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
    }
}
