//
//  Product.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import Unrealm

struct Product: Codable, Distinguishable, LocalDataStorable, Purchasable {
    var id = ""
    var sku = ""
    var name = ""
    var brand = ""
    var price = 0
    var originalPrice: Int?
    var badges: [Badge] = []
    var image = ""
}

extension Product {
    init(_ purchasable: Purchasable) {
        self.id = purchasable.id
        self.sku = purchasable.sku
        self.name = purchasable.name
        self.brand = purchasable.brand
        self.price = purchasable.price
        self.originalPrice = purchasable.originalPrice
        self.badges = purchasable.badges
        self.image = purchasable.image
    }
}
