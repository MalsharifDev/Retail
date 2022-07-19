//
//  BadgeView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import SwiftUI

struct BadgeView: View {

    let title: String
    let font: Font
    let height: CGFloat

    var body: some View {
        Text(title)
            .font(font)
            .padding(6)
            .foregroundColor(.black)
            .frame(width: .none, height: height)
            .background(Color.lightGray)
            .opacity(0.8)
    }
}
