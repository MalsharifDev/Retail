//
//  ProductDetailViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import UIKit

final class ProductDetailViewModel: ProductViewModel {

    // Published Properties
    @Published var isAddedToCart = false

    // Convenience Properties
    private var isItemInCart: Bool {
        Cart.all(in: localStorage).first?.items.first(where: { $0.id == item.id }) != nil
    }

    private var isCartStored: Bool {
        !Cart.all(in: localStorage).isEmpty
    }

    private var storedCart: Cart {
        Cart.all(in: localStorage).first ?? Cart()
    }

    // MARK: - Init
    
    override init(item: Purchasable, currency: String) {
        super.init(item: item, currency: currency)

        if isItemInCart {
            self.isAddedToCart = true
        }
    }

    // MARK: - UI Events

    func addToCart() {
        var cart = Cart(id: UUID().uuidString, items: [])
        let cartItem = CartItem(item)

        if isCartStored {
            cart = storedCart
        }

        isAddedToCart.toggle()

        cart.items.append(cartItem)
        cart.store(in: localStorage)
    }
}
