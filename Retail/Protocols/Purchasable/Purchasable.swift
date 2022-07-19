//
//  Purchasable.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Foundation

/**
    `Purchasable` is a protocol that represents any purchasable item that shares its properties
    such as products, wishlist items, cart items... etc.
*/
protocol Purchasable {
    var id: String { get set }
    var sku: String { get set }
    var name: String { get set }
    var brand: String { get set }
    var price: Int { get set }
    var originalPrice: Int? { get set }
    var badges: [Badge] { get set }
    var image: String { get set }
}
