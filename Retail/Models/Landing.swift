//
//  Landing.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Unrealm

struct Landing: Codable, LocalDataStorable {
    var title = ""
    var currency = ""
    var items: [Product] = []

    static func primaryKey() -> String? {
        return "title"
    }
}

extension Landing {
    var isEmpty: Bool {
        title.isEmpty && currency.isEmpty && items.isEmpty
    }
}
