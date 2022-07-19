//
//  ProductViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Foundation

class ProductViewModel: PurchasableItemViewModel {

    // Published Properties
    @Published var isBookmarked = false

    // Convenience Properties
    private var isItemInWishlist: Bool {
        Wishlist.all(in: localStorage).first?.items.first(where: { $0.id == item.id }) != nil
    }

    private var isWishlistStored: Bool {
        !Wishlist.all(in: localStorage).isEmpty
    }

    private var storedWishlist: Wishlist {
        Wishlist.all(in: localStorage).first ?? Wishlist()
    }

    // MARK: - Init

    override init(item: Purchasable, currency: String) {
        super.init(item: item, currency: currency)

        if isItemInWishlist {
            self.isBookmarked = true
        }
    }

    // MARK: - UI Events

    func bookmark() {
        var wishlist = Wishlist(id: UUID().uuidString, items: [])
        let wishlistItem = WishlistItem(item)

        if isWishlistStored {
            wishlist = storedWishlist
        }

        isBookmarked.toggle()

        if isBookmarked {
            wishlist.items.append(wishlistItem)
        } else if let index = wishlist.items.firstIndex(where: { $0.id == wishlistItem.id }) {
            wishlist.items.remove(at: index)
        }

        wishlist.store(in: localStorage)
    }
}
