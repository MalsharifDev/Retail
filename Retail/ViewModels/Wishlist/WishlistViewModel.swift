//
//  WishlistViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import SwiftUI

final class WishlistViewModel: ObservableObject {

    // Local Storage
    private let localStorage = Retail.localStorage

    // Observer Properties
    private var storageNotificationToken: StorageNotificationToken?

    // Published Properties
    @Published var wishlist = Wishlist(id: "", items: [])
    @Published var currency = ""

    // UI Properties
    var shouldDismiss: Bool {
        !wishlist.id.isEmpty && wishlist.items.isEmpty
    }

    var title: String {
        "\(AppView.Wishlist.navBarTitle) (\(wishlist.items.count))"
    }

    // MARK: - Init

    init(currency: String) {
        self.currency = currency

        storageNotificationToken = Wishlist.all(in: localStorage).observe { [weak self] _ in
            self?.getWishlist()
        }
    }

    // MARK: - Data Refresh

    func getWishlist() {
        wishlist = Wishlist.all(in: localStorage).first ?? wishlist
    }
}
