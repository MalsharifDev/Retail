//
//  ProductView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import SwiftUI

struct ProductView: View {

    @ObservedObject var viewModel: ProductViewModel

    let imageSize = CGSize(width: 130, height: 200)

    var body: some View {
        VStack(alignment: .leading) {
            productImage
                .overlay(buttonOverlay, alignment: .topTrailing)

            productDescriptionView
        }
        .frame(width: 180, height: 275)
        .padding(.top, 45)
        .padding([.leading, .trailing])
    }
}

extension ProductView {

    private var productImage: some View {
        ProductImage(
            imageURL: viewModel.imageURL,
            imageSize: imageSize,
            badgeOverlay: badgeOverlay
        )
    }

    private var badgeOverlay: BadgeOverlay {
        BadgeOverlay(badges: viewModel.badges)
    }

    private var buttonOverlay: some View {
        ZStack {
            SFSymbolButton(symbolName: viewModel.isBookmarked ? .bookmarkFill : .bookmark) {
                viewModel.bookmark()
            }
            .padding(7)
        }
    }

    private var productDescriptionView: some View {
        ProductDescriptionView(
            brand: viewModel.brand,
            name: viewModel.name,
            price: viewModel.price,
            originalPrice: viewModel.originalPrice,
            horizontalAlignment: .leading
        )
    }
}

struct ProductView_Previews: PreviewProvider {
    static let mockProductViewModel = ProductViewModel(
        item:
            WishlistItem(
                id: "",
                sku: "",
                name: "Name of Item",
                brand: "Brand of Item",
                price: 1000,
                originalPrice: 1099,
                badges: [.kidsUnisex, .new, .sale],
                image: "https://i.imgur.com/ZRm6gdhm.jpg"
            ),
        currency: "AED"
    )

    static var previews: some View {
        ProductView(viewModel: mockProductViewModel)
    }
}
