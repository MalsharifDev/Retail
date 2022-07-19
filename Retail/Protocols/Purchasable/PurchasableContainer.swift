//
//  PurchasableContainer.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import Foundation

/**
    `PurchasableContainer` is a protocol that represents any purchasable item container that shares its properties
    such as wishlists, carts... etc.
*/
protocol PurchasableContainer: Codable, Equatable, LocalDataStorable {
    associatedtype Item

    var id: String { get set }
    var items: [Item] { get set }
    static func primaryKey() -> String?
}

extension PurchasableContainer {
    static func primaryKey() -> String? {
        "id"
    }
}
