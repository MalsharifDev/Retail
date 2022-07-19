//
//  Cart.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import Foundation

typealias CartItem = Product

struct Cart: PurchasableContainer {
    var id = ""
    var items: [CartItem] = []
}
