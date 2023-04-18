//
//  ProductDetailView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import SwiftUI

struct ProductDetailView: View {

    @ObservedObject var viewModel: ProductDetailViewModel
    @Environment(\.presentationMode) var mode

    private let imageSize = CGSize(width: UIScreen.width - 32, height: UIScreen.height - 450)

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                productImage
                productDescriptionView
                addToBagButtonView
            }
            .navigationBarItems(leading: Button { } label: {
                SFSymbolButton(symbolName: .arrowBackward) {
                    mode.wrappedValue.dismiss()
                }
            }, trailing: Button { } label: {
                SFSymbolButton(symbolName: viewModel.isBookmarked ? .bookmarkFill : .bookmark) {
                    viewModel.bookmark()
                }
            })
        }
        .navigationBarHidden(true)
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
        }
        .onDisappear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .all
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {

    static let mockProductDetailView = ProductDetailViewModel(
        item:
            Product(
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
        ProductDetailView(viewModel: mockProductDetailView)
    }
}

extension ProductDetailView {

    private var productImage: some View {
        ProductImage(
            imageURL: viewModel.imageURL,
            imageSize: imageSize,
            badgeOverlay: badgeOverlay
        )
    }

    private var badgeOverlay: BadgeOverlay {
        BadgeOverlay(
            badges: viewModel.badges,
            spacing: 10,
            padding: 12,
            font: .system(size: 15),
            height: 30
        )
    }

    private var productDescriptionView: some View {
        ProductDescriptionView(
            brand: viewModel.brand,
            name: viewModel.name,
            price: viewModel.price,
            originalPrice: viewModel.originalPrice,
            brandFont: .system(size: 15),
            nameFont: .system(size: 21),
            priceFont: .system(size: 16),
            horizontalAlignment: .center
        )
            .padding([.leading, .trailing])
    }

    private var addToBagButtonView: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .shadow(color: .lightGray.opacity(1), radius: 10, x: 0, y: -1)
                .overlay(
                    Button {
                        viewModel.addToCart()
                    } label: {
                        ZStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 2.5)
                                    .foregroundColor(viewModel.isAddedToCart ? .gray : .black)
                            }
                            .padding([.leading, .trailing])
                            
                            Text(AppView.ProductDetail.addToBagButtonLabel)
                        }
                    }
                        .disabled(viewModel.isAddedToCart)
                        .frame(maxWidth: .infinity, maxHeight: 55, alignment: .center)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing, .bottom])
                )
                .ignoresSafeArea()
        }
    }
}
