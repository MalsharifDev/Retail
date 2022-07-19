//
//  ProductImage.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/18/22.
//

import SwiftUI

struct ProductImage: View {

    let imageURL: String
    let imageSize: CGSize
    let badgeOverlay: BadgeOverlay

    var body: some View {
        RemoteImage(from: imageURL, size: imageSize)
            .frame(width: imageSize.width, height: imageSize.height)
            .padding()
            .background(
                Rectangle()
                    .fill(.white)
                    .shadow(color: .lightGray.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            .overlay(badgeOverlay, alignment: .topLeading)
    }
}
