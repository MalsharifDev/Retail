//
//  Badge.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Unrealm

enum Badge: String, Codable, StorableEnum {
    case sale = "SALE"
    case new = "NEW"
    case women = "WOMEN"
    case kidsUnisex = "KIDSUNISEX"
}
