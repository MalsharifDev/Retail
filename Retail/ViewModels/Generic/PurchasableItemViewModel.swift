//
//  PurchasableItemViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import Foundation

class PurchasableItemViewModel: ObservableObject {

    // Local Storage
    let localStorage = Retail.localStorage

    // Published Properties
    @Published var item: Purchasable
    @Published var currency: String

    // UI Properties
    var imageURL: String {
        item.image
    }

    var brand: String {
        item.brand
    }

    var name: String {
        item.name
    }

    var price: String {
        "\(item.price) \(currency)"
    }

    var originalPrice: String? {
        guard let originalPrice = item.originalPrice else { return nil }

        return "\(originalPrice) \(currency)"
    }

    var badges: [Badge] {
        item.badges
    }

    // MARK: - Init

    init(item: Purchasable, currency: String) {
        self.item = item
        self.currency = currency
    }
}
