//
//  WishlistItemView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import SwiftUI

struct WishlistItemView: View {

    @ObservedObject var viewModel: WishlistItemViewModel

    @State private var shouldShowDetailView = false

    var imageSize = CGSize(width: UIScreen.width / 3.3, height: 190)

    var body: some View {
        ZStack {
            let productDetailViewModel = ProductDetailViewModel(
                item: viewModel.item,
                currency: viewModel.currency
            )

            NavigationLink(
                destination: ProductDetailView(viewModel: productDetailViewModel),
                isActive: $shouldShowDetailView) {
                    Button {
                        shouldShowDetailView.toggle()
                    } label: {
                        EmptyView()
                    }
                }
                .isDetailLink(false)
                .opacity(0)
                .buttonStyle(.plain)

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    productImage
                    productDescriptionView
                        .padding(.leading, 20)
                }
                .padding()

                HStack {
                    Spacer()
                    removeButton
                }
            }
            .frame(width: .none, height: .none)
            .padding(.bottom)
        }
    }

}

extension WishlistItemView {

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

    private var productDescriptionView: some View {
        ProductDescriptionView(
            brand: viewModel.brand,
            name: viewModel.name,
            price: viewModel.price,
            originalPrice: viewModel.originalPrice,
            horizontalAlignment: .leading,
            topPadding: 0
        )
    }

    private var removeButton: some View {
        Button {
            viewModel.removeItem()
        } label: {
            HStack {
                Image(systemName: .trash)
                    .font(.title3)

                Text(AppView.WishlistItem.removeButtonLabel)
                    .font(.body)
                    .underline()
            }
        }
        .padding(.trailing, 40)
        .foregroundColor(.black)
    }
}

struct WishlistItemView_Previews: PreviewProvider {
    static let mockWishlistItemViewModel = WishlistItemViewModel(
        item:
            WishlistItem(
                id: "",
                sku: "",
                name: "Name of Item",
                brand: "Brand of Item",
                price: 1000,
                originalPrice: 199,
                badges: [.kidsUnisex, .new, .sale],
                image: "https://i.imgur.com/ZRm6gdhm.jpg"
            ),
        currency: "AED"
    )

    static var previews: some View {
        WishlistItemView(viewModel: mockWishlistItemViewModel)
    }
}
