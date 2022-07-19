//
//  ProductDescriptionView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/18/22.
//

import SwiftUI

struct ProductDescriptionView: View {

    let brand: String
    let name: String
    let price: String
    let originalPrice: String?

    var brandFont: Font = .system(size: 13)
    var nameFont: Font = .callout
    var priceFont: Font = .footnote
    var horizontalAlignment: HorizontalAlignment = .leading

    var body: some View {
        VStack(alignment: horizontalAlignment) {
            Text(brand)
                .bold()
                .padding(.top)
                .font(brandFont)

            Text(name)
                .font(nameFont)

            HStack(spacing: 10) {
                Text(price)
                    .font(priceFont)

                if let originalPrice = originalPrice {
                    Text(originalPrice)
                        .strikethrough()
                        .font(priceFont)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 1)
        }
        .padding(.top, 1)
        .padding(.bottom)
    }
}
