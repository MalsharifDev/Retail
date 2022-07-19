//
//  WishlistItemViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Foundation

final class WishlistItemViewModel: PurchasableItemViewModel {

    // MARK: - UI Events

    func removeItem() {
        guard
            var wishlist = Wishlist.all(in: localStorage).first,
            let index = wishlist.items.firstIndex(where: { $0.id == item.id })
        else { return }

        wishlist.items.remove(at: index)
        wishlist.store(in: localStorage)
    }
}
