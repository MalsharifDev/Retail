//
//  Wishlist.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Unrealm

typealias WishlistItem = Product

struct Wishlist: PurchasableContainer {
    var id = ""
    var items: [WishlistItem] = []
}
